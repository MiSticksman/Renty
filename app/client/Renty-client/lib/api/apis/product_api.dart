import 'package:client/api/dto/response/product/product.dart';
import 'package:client/api/dto/response/product/product_preview.dart';
import 'package:client/api/dto/response/product/size.dart';
import 'package:client/common/utils/http_util.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:dio/dio.dart';

class ProductApi {
  Future<ProductResponse> productById(int productId) async {
    var path = 'catalog/products/${productId}';
    var response = await HttpUtil().get(
      path,
    );
    var jsonData = response.data;
    var res = ProductResponse.fromJson(jsonData);
    return res;
  }

  Future<List<ProductResponse>> products() async {
    var path = 'catalog/products';
    var response = await HttpUtil().get(
      path,
    );
    var jsonData = response.data;
    var res = List<ProductResponse>.from(
        jsonData.map((x) => ProductResponse.fromJson(x)));
    return res;
  }

  Future<ProductPreviewResponse> productPreview(int productId) async {
    var path = 'catalog/products/previews/${productId}';
    var response = await HttpUtil().get(
      path,
    );
    var jsonData = response.data;
    var res = ProductPreviewResponse.fromJson(jsonData);
    return res;
  }

  Future<List<ProductPreviewResponse>> productsPreviews(
      {Map<String, dynamic>? query}) async {
    var path = 'catalog/products/previews';
    var response = await HttpUtil().get(path, queryParameters: query);
    var jsonData = response.data;
    var res = List<ProductPreviewResponse>.from(
        jsonData.map((x) => ProductPreviewResponse.fromJson(x)));
    return res;
  }

  Future<List<SizeResponse>> productSizes(int productId) async {
    var path = 'catalog/products${productId}/sizes';
    var response = await HttpUtil().get(
      path,
    );
    var jsonData = response.data;
    var res =
        List<SizeResponse>.from(jsonData.map((x) => SizeResponse.fromJson(x)));
    return res;
  }

  Future<int?> sizeCountUpdate(int productId, Map<String, dynamic> size) async {
    var path = 'catalog/products/${productId}/sizes';
    try {
      var statusCode = await HttpUtil().patch(path, size);
      if (statusCode == 200) {
        return statusCode;
      } else {
        toastInfo(msg: "Не изменено");
      }
    } on DioError catch (e) {
      toastInfo(msg: "Ошибка при изменении количества");
    }
    return null;
  }

  Future<int?> sizeDelete(int productId, Map<String, dynamic> size) async {
    var path = 'catalog/products/${productId}/sizes';
    try {
      var statusCode = await HttpUtil().delete(path, size);
      if (statusCode == 200) {
        return statusCode;
      } else {
        toastInfo(msg: "Ошибка! Возможно, товар в аренде");
      }
    } on DioError catch (e) {}
    return null;
  }

  Future<int?> sizeCreate(int productId, Map<String, dynamic> size) async {
    var path = 'catalog/products/${productId}/sizes';
    try {
      var statusCode = await HttpUtil().post(path, data: size);
      if (statusCode == 200) {
        return statusCode;
      } else {
        toastInfo(msg: "Размер не был создан");
      }
    } on DioError catch (e) {
      toastInfo(msg: "Ошибка при создании размера");
    }
    return null;
  }

  Future<int?> productCreate(Map<String, dynamic> body) async {
    var path = 'catalog/products';
    try {
      var statusCode = await HttpUtil().post(path, data: body);
      if (statusCode == 200) {
        return statusCode;
      } else {
        toastInfo(msg: "Товар не был создан");
      }
    } on DioError catch (e) {
      toastInfo(msg: "Ошибка при создании товара");
    }
    return null;
  }

  Future<int?> productDelete(int id) async {
    var path = 'catalog/products/${id}';
    try {
      var code = await HttpUtil().delete(path, null);
      if (code == 200) {
        toastInfo(msg: "Товар удален");
        return code;
      } else {
        toastInfo(msg: "Этот товар сейчас удалить нельзя");
      }
    } on DioError catch (e) {
      toastInfo(msg: "Ошибка при удалении товара");
    }
    return null;
  }
}
