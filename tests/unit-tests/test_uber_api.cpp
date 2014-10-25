#include <gtest/gtest.h>
#include <uberapi.h>

TEST(UberAPITest, can_authenticate)
{
        UberAPI uberapi;
        EXPECT_EQ(uberapi.client_id(), "1xRXYLdYXuNSQBSfmHzbDfnNUmZtuxZn");
}


