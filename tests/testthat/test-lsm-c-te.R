context("class level lsm_c_te metric")

landscapemetrics_class_landscape_value <- lsm_c_te(landscape)

test_that("lsm_c_te is typestable", {
    expect_is(lsm_c_te(landscape), "tbl_df")
    expect_is(lsm_c_te(landscape_stack), "tbl_df")
    expect_is(lsm_c_te(landscape_brick), "tbl_df")
    expect_is(lsm_c_te(landscape_list), "tbl_df")
})

test_that("lsm_c_te returns the desired number of columns", {
    expect_equal(ncol(landscapemetrics_class_landscape_value), 6)
})

test_that("lsm_c_te returns in every column the correct type", {
    expect_type(landscapemetrics_class_landscape_value$layer, "integer")
    expect_type(landscapemetrics_class_landscape_value$level, "character")
    expect_type(landscapemetrics_class_landscape_value$class, "integer")
    expect_type(landscapemetrics_class_landscape_value$id, "integer")
    expect_type(landscapemetrics_class_landscape_value$metric, "character")
    expect_type(landscapemetrics_class_landscape_value$value, "double")
})

test_that("lsm_l_te equals 0 if only one patch is present",  {
    result <- lsm_c_te(landscape_uniform, count_boundary = FALSE)
    expect_equal(result$value, 0)
})

test_that("lsm_c_te can handle raster with different xy resolution", {
    expect_is(lsm_c_te(landscape_diff_res), "tbl_df")
})
