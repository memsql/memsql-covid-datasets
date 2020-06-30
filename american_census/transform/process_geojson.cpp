#include "vendor/json.hpp"
#include <iostream>
#include <fstream>
#include <sstream>

using json = nlohmann::json;
using namespace std;

string toWKTPolygon(json polygon) {
    stringstream out;
    out << "POLYGON (";
    for (json part: polygon) {
        out << "(";
        bool first = true;
        for (json lonlat: part) {
            if (first) {
                first = false;
            } else {
                out << ", ";
            }
            out << lonlat[0] << " " << lonlat[1];
        }
        out << ")";
    }
    out << ")";
    return out.str();
}

int main(int argc, char **argv) {
    std::ifstream input(argv[1]);
    json jsonDoc;
    input >> jsonDoc;

    for (json feature: jsonDoc["features"]) {
        // coordinates is a list of polygons
        for (json polygon: feature["geometry"]["coordinates"]) {
            cout
                << feature["properties"]["CensusBlockGroup"].get<string>()
                << "\t"
                << feature["properties"]["State"].get<string>()
                << "\t"
                << feature["properties"]["County"].get<string>()
                << "\t"
                << toWKTPolygon(polygon)
                << "\n";
        }
    }
}
