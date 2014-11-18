#include <gtest/gtest.h>

#include <iostream>
#include <fstream>

// Find the icon file
TEST(TestAssetPaths, can_find_icon_file)
{
    EXPECT_TRUE(std::ifstream(ICON_FILE_PATH));
}
