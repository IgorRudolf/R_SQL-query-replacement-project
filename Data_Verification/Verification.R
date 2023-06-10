#all.equal(sql_1(Users),base_1(Users))
#all.equal(sql_1(Users),dplyr_1(Users))
#all.equal(sql_1(Users),table_1(Users))


#microbenchmark::microbenchmark(sqldf=sql_1(Users),base=base_1(Users), dplyr= dplyr_1(Users),table= table_1(Users))

# Unit: milliseconds
# expr      min        lq      mean   median        uq      max neval
# sqldf 168.5078 175.69570 188.98042 183.1930 194.60110 247.9721   100
# base 107.2228 111.45980 123.08215 117.1898 128.42950 199.3447   100
# dplyr  25.4601  26.88685  36.79087  29.2552  35.18215  97.5177   100
# table  15.0579  18.81185  20.04109  19.9949  21.06835  26.5566   100

#all.equal(sql_2(Posts),base_2(Posts))
#all.equal(sql_2(Posts),dplyr_2(Posts))
#all.equal(sql_2(Posts),table_2(Posts))


#microbenchmark::microbenchmark(sqldf=sql_2(Posts),base=base_2(Posts), dplyr= dplyr_2(Posts),table= table_2(Posts))

# Unit: milliseconds
# expr       min       lq     mean   median       uq      max neval
# sqldf  987.5998 1033.929 1087.713 1074.537 1121.129 1725.285   100
# base 3408.2740 3560.401 3713.579 3677.814 3773.225 5787.145   100
# dplyr 3409.4791 3523.810 3655.057 3600.946 3719.867 4959.386   100
# table 3358.4539 3543.399 3638.706 3640.051 3724.153 4033.846   100


#all.equal(sql_3(Posts,Users),base_3(Posts,Users))
#all.equal(sql_3(Posts,Users),dplyr_3(Posts,Users))
#all.equal(sql_3(Posts,Users),table_3(Posts,Users))

#microbenchmark::microbenchmark(sqldf=sql_3(Posts,Users),base=base_3(Posts,Users), dplyr= dplyr_3(Posts,Users),table= table_3(Posts,Users))

# Unit: milliseconds
# expr       min         lq       mean    median         uq       max neval
# sqldf 1169.3915 1254.14095 1297.61959 1296.5440 1330.37915 1519.6543   100
# base  269.2999  283.91400  316.25600  298.7699  341.57570  510.5221   100
# dplyr   65.7179  101.43340  120.52818  121.5934  132.53980  318.6229   100
# table   52.1566   54.39125   63.02394   57.9899   62.20165  134.6371   100


#all.equal(sql_4(Posts,Users),base_4(Posts,Users))
#all.equal(sql_4(Posts,Users),dplyr_4(Posts,Users))
#all.equal(sql_4(Posts,Users),table_4(Posts,Users))


#microbenchmark::microbenchmark(sqldf=sql_4(Posts,Users),base=base_4(Posts,Users), dplyr= dplyr_4(Posts,Users),table= table_4(Posts,Users))

# Unit: milliseconds
# expr       min         lq       mean    median        uq       max neval
# sqldf 1139.4156 1296.18760 1320.20462 1323.2933 1361.8600 2097.0052   100
# base  338.5454  398.64035  447.21887  443.9573  455.9987  713.1025   100
# dplyr   69.4192   88.66240  112.89033  104.4531  136.6986  350.8426   100
# table   44.2357   50.15275   69.97279   52.7454  101.5672  131.5018   100


#all.equal(sql_5(Posts,Comments,Users),base_5(Posts,Comments,Users))
#all.equal(sql_5(Posts,Comments,Users),dplyr_5(Posts,Comments,Users))
#all.equal(sql_5(Posts,Comments,Users),table_5(Posts,Comments,Users))


#microbenchmark::microbenchmark(sqldf=sql_5(Posts,Comments, Users),base=base_5(Posts,Comments,Users), dplyr= dplyr_5(Posts,Comments,Users),table= table_5(Posts,Comments,Users))

# Unit: milliseconds
# expr       min         lq       mean    median        uq       max neval
# sqldf 1387.4556 1479.57350 1558.76746 1550.8236 1601.8447 2032.3164   100
# base  909.4900  968.56090 1038.35741 1027.3481 1073.8202 1395.8605   100
# dplyr  203.4301  271.34930  321.67980  301.9220  347.5070  571.3630   100
# table   52.4023   60.07615   97.94663   95.7728  110.3392  308.7674   100