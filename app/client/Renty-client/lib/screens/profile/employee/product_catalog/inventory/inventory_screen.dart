import 'package:client/api/dto/response/product/product_preview.dart';
import 'package:client/bloc/product/product_bloc.dart';
import 'package:client/bloc/product/product_event.dart';
import 'package:client/bloc/product/product_state.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:client/common/widgets/bar/app_bar.dart';
import 'package:client/common/widgets/bar/bottom_nav_bar.dart';
import 'package:client/common/widgets/button_widget.dart';
import 'package:client/common/widgets/text/text_widgets.dart';
import 'package:client/controller/product_controller.dart';
import 'package:client/screens/profile/employee/product_catalog/catalog_menu.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/new_product.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/product_size/quantity_editing.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/widgets/inventory_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  late ProductController _homeController;

  String search = "";

  @override
  void initState() {
    super.initState();
    _homeController = ProductController(context: context);
    _homeController.initProductsPreviews();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductsPreviewsLoadedState) {
          return _buildProductsWidget(state.productsPreviews);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildProductsWidget(List<ProductPreviewResponse> productsPreviews) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          title: "Инвентарь",
          backFun: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CatalogMenu(),
              ),
            );
          },
        ),
        body: Container(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Row(
                    children: [
                      buildTextField(
                        height: 45,
                        width: 260,
                        "Поиск",
                        'search',
                        (value) {
                          search = value;
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 15.w, right: 5.w, bottom: 35.h),
                        child: GestureDetector(
                          onTap: () {
                            context.read<ProductBloc>().add(
                                ProductsPreviewsSearchEvent(search: search));
                          },
                          child: const Icon(
                            FontAwesomeIcons.magnifyingGlass,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 5.h,
                  horizontal: 10.w,
                ),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 2.5,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    childCount: productsPreviews.length,
                    (BuildContext context, int index) {
                      ProductPreviewResponse productPreview =
                          productsPreviews[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductQuantityScreen(
                                  productId: productPreview.productId),
                            ),
                          );
                        },
                        child: inventoryItemGrid(productPreview, context),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 30.h, bottom: 20.h),
                  child: buildButton(
                    "Добавить товар",
                    "secondary",
                    () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const NewProductScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: MyBottomNavBar(selectedIndex: 3),
      ),
    );
  }
}
