//mendaftarkan class yg lain (ini yg utama) menggunakan part
//diclass lain perlu ditambahkan part of
//hasil importnya jg akan terkumpul diclass ini

import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:mvvm/view/widgets/widgets.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvvm/viewmodel/shipping_viewmodel.dart';


part 'counter_page.dart';
part 'home_page.dart';
part 'main_menu.dart';
part 'shipping_calculator_page.dart';