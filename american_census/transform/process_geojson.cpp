#include "vendor/json.hpp"
#include <iostream>
#include <fstream>
#include <sstream>

using json = nlohmann::json;
using namespace std;

string toWKTPolygon(json polygon) {
    stringstream out;
    out << "POLYGON (";
    bool first_part = true;
    for (json part: polygon) {
        if (first_part) {
            first_part = false;
        } else {
            out << ", ";
        }
        out << "(";
        bool first_lonlat = true;
        for (json lonlat: part) {
            if (first_lonlat) {
                first_lonlat = false;
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

string handleStr(json val) {
    if (val.is_null()) {
        return "";
    }
    return val.get<string>();
}

int main(int argc, char **argv) {
    std::ifstream input(argv[1]);
    json jsonDoc;
    input >> jsonDoc;

    for (json feature: jsonDoc["features"]) {
        // coordinates is a list of polygons
        for (json polygon: feature["geometry"]["coordinates"]) {
            cout
                << handleStr(feature["properties"]["CensusBlockGroup"])
                << "\t"
                << handleStr(feature["properties"]["State"])
                << "\t"
                << handleStr(feature["properties"]["County"])
                << "\t"
                << toWKTPolygon(polygon)
                << "\n";
        }
    }
}
