#include "vendor/csv.hpp"

using namespace csv;

int main(int argc, char **argv) {
    CSVFormat format;
    format.delimiter(',').header_row(0).quote(false);

    CSVReader reader(argv[1], format);

    auto columns = reader.get_col_names();

    for (CSVRow& row: reader) {
        auto cbg = row["census_block_group"].get<>();

        int i = 0;
        for (CSVField& field: row) {
            if (i == 0) {
                // already grabbed cbg
                i++;
                continue;
            }

            std::cout << cbg << "\t" << columns[i] << "\t" << field.get<string_view>() << "\n";
            i++;
        }
    }
}
