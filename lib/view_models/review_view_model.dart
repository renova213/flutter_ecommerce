import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../data/repository/apps_repository.dart';
import '../models/review_model.dart';
import '../utils/utils.dart';

class ReviewViewModel extends ChangeNotifier {
  final AppsRepository appsRepository = AppsRepository();

  List<ReviewModel> _reviews = [];
  final List<ReviewModel> _oneRatingReviews = [];
  final List<ReviewModel> _twoRatingReviews = [];
  final List<ReviewModel> _threeRatingReviews = [];
  final List<ReviewModel> _fourRatingReviews = [];
  final List<ReviewModel> _fiveRatingReviews = [];
  AppState _appState = AppState.loading;
  double averageRating5 = 0.0;
  double averageRating4 = 0.0;
  double averageRating3 = 0.0;
  double averageRating2 = 0.0;
  double averageRating1 = 0.0;
  double averageSumRating = 0.0;
  double _userRating = 5.0;
  String _satisfactionText = "";
  String _hintText = "";
  String _imageCheck = "";
  String _input = "";
  late File _image;
  final _imagePicker = ImagePicker();
  final TextEditingController _reviewController = TextEditingController();

  double get userRating => _userRating;
  List<ReviewModel> get reviews => _reviews;
  AppState get appState => _appState;
  List<ReviewModel> get oneRatingReviews => _oneRatingReviews;
  List<ReviewModel> get twoRatingReviews => _twoRatingReviews;
  List<ReviewModel> get threeRatingReviews => _threeRatingReviews;
  List<ReviewModel> get fourRatingReviews => _fourRatingReviews;
  List<ReviewModel> get fiveRatingReviews => _fiveRatingReviews;
  TextEditingController get reviewController => _reviewController;
  String get satisfactionText => _satisfactionText;
  String get hintText => _hintText;
  String get imageCheck => _imageCheck;
  String get input => _input;
  File get image => _image;

  Future<void> fetchReviews(int productId) async {
    await clearRating();

    try {
      changeAppState(AppState.loading);
      _reviews = await appsRepository.fetchReview(productId: productId);
      await filterRating();
      await calculateAveragePerRatingProduct();
      await calculateAverageSumRatingProduct();
      changeAppState(AppState.loaded);

      if (_reviews.isEmpty) {
        changeAppState(AppState.noData);
      }
    } catch (e) {
      changeAppState(AppState.failure);
      rethrow;
    }
  }

  Future<void> deleteReview(
      {required int reviewId, required int productId}) async {
    try {
      await appsRepository.deleteReview(reviewId).then(
            (_) async => await fetchReviews(productId),
          );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> postReview(
      {required int productId,
      required String review,
      required File image,
      required String star}) async {
    try {
      await appsRepository.postReview(
          productId: productId, review: review, image: image, star: star);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateReview(
      {required int reviewId,
      required int productId,
      required String review,
      required File image,
      required String star}) async {
    try {
      await appsRepository.updateReview(
          reviewId: reviewId, review: review, image: image, star: star);
      fetchReviews(productId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> filterRating() async {
    for (var i in _reviews) {
      if (i.star == 1 && !_oneRatingReviews.contains(i)) {
        _oneRatingReviews.add(i);
        notifyListeners();
      }
      if (i.star == 2 && !_twoRatingReviews.contains(i)) {
        _twoRatingReviews.add(i);
        notifyListeners();
      }
      if (i.star == 3 && !_threeRatingReviews.contains(i)) {
        _threeRatingReviews.add(i);
        notifyListeners();
      }
      if (i.star == 4 && !_fourRatingReviews.contains(i)) {
        _fourRatingReviews.add(i);
        notifyListeners();
      }
      if (i.star == 5 && !_fiveRatingReviews.contains(i)) {
        _fiveRatingReviews.add(i);
        notifyListeners();
      }
    }
  }

  Future<void> calculateAveragePerRatingProduct() async {
    averageRating5 = _fiveRatingReviews.length / _reviews.length;
    averageRating4 = _fourRatingReviews.length / _reviews.length;
    averageRating3 = _threeRatingReviews.length / _reviews.length;
    averageRating2 = _twoRatingReviews.length / _reviews.length;
    averageRating1 = _oneRatingReviews.length / _reviews.length;

    notifyListeners();
  }

  Future<void> calculateAverageSumRatingProduct() async {
    averageSumRating = ((1 * _oneRatingReviews.length) +
            (2 * _twoRatingReviews.length) +
            (3 * _threeRatingReviews.length) +
            (4 * _fourRatingReviews.length) +
            (5 * _fiveRatingReviews.length)) /
        _reviews.length;
  }

  Future<void> clearRating() async {
    _input = "";
    _reviewController.clear();
    _oneRatingReviews.clear();
    _twoRatingReviews.clear();
    _threeRatingReviews.clear();
    _fourRatingReviews.clear();
    _fiveRatingReviews.clear();
    averageRating5 = 0.0;
    averageRating4 = 0.0;
    averageRating3 = 0.0;
    averageRating2 = 0.0;
    averageRating1 = 0.0;
    averageSumRating = 0.0;
    notifyListeners();
  }

  void inputRating(double userRating) {
    _imageCheck = "Kasih liat foto barang";
    _satisfactionText = "";
    _hintText = "";
    _userRating = userRating;
    notifyListeners();

    if (_userRating == 5) {
      _satisfactionText = "Apa yang bikin kamu puas?";
      _hintText = "Yuk, ceritain kepuasanmu tentang kualitas barangnya";
      notifyListeners();
    }

    if (_userRating == 4) {
      _satisfactionText = "Apa yang bikin kamu puas?";
      _hintText = "Yuk, ceritain kepuasanmu tentang kualitas barangnya";
      notifyListeners();
    }

    if (_userRating == 3) {
      _satisfactionText = "Apa yang bikin kamu kurang puas?";
      _hintText = "Kasih tau apa yang kurang dan yang perlu ditingkatkan";
      notifyListeners();
    }

    if (_userRating == 2) {
      _satisfactionText = "Apa yang bikin kamu tidak puas?";
      _hintText =
          "Ceritain lebih lengkap apa yang bikin kamu tidak puas dan perlu ditingkatkan";
      notifyListeners();
    }

    if (_userRating == 1) {
      _satisfactionText = "Apa yang bikin kamu kecewa?";
      _hintText =
          "Ceritain lebih lengkap apa yang bikin kamu kecewa dan perlu ditingkatkan";
      notifyListeners();
    }
  }

  void getImage() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _image = File(image.path);
      _imageCheck = "Foto berhasil disimpan";
      notifyListeners();
    }
  }

  void changeInput(String value) {
    _input = value;
    notifyListeners();
  }

  void changeAppState(AppState appState) async {
    _appState = appState;
    notifyListeners();
  }
}
