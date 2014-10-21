#include <gtest/gtest.h>
#include <libconfig.h++>

using namespace libconfig;

// This checks that the file exists and is parsible, not necessarily vaild
TEST(TestConfigFile, can_find_valid_config_file)
{
    Config cfg;
    EXPECT_NO_THROW({
        cfg.readFile(CONFIG_FILE_PATH);
    });
}
