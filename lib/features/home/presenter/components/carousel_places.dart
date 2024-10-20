import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sp_pontos/core/components/text_app.dart';
import 'package:sp_pontos/core/models/place_carrousel.dart';
import 'package:sp_pontos/core/styles/app_colors.dart';
import 'package:sp_pontos/core/styles/app_font_size.dart';

class CarouselPlaces extends StatefulWidget {
  @override
  _CarouselPlacesState createState() => _CarouselPlacesState();
}

class _CarouselPlacesState extends State<CarouselPlaces> {
  int _currentIndex = 0;
  late PageController _pageController; // Declare PageController

  final List<PlaceCarrousel> _places = [
    PlaceCarrousel(
      name: 'Parque Ibirapuera',
      location: 'Cidade de São Paulo - SP',
      imageUrl:
          'https://litoralempauta.com.br/wp-content/uploads/2024/01/shutterstock_1474895630-scaled.jpg',
    ),
    PlaceCarrousel(
      name: 'Praia de Santos',
      location: 'Santos - SP',
      imageUrl:
          'https://litoralempauta.com.br/wp-content/uploads/2024/01/shutterstock_1474895630-scaled.jpg',
    ),
    PlaceCarrousel(
      name: 'Museu do Ipiranga',
      location: 'São Paulo - SP',
      imageUrl:
          'https://litoralempauta.com.br/wp-content/uploads/2024/01/shutterstock_1474895630-scaled.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(); // Initialize PageController
  }

  @override
  void dispose() {
    _pageController
        .dispose(); // Clean up the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 250,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
                _pageController.jumpToPage(index); // Sync the PageController
              });
            },
          ),
          items: _places.map((place) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: place.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            );
          }).toList(),
        ),
        Positioned(
          top: 11,
          left: 16,
          child: SmoothPageIndicator(
            controller: _pageController, // Bind the PageController here
            count: _places.length,
            effect: WormEffect(
              dotWidth: 10,
              dotHeight: 10,
              activeDotColor: AppColors.blue,
              dotColor: AppColors.gray,
            ),
          ),
        ),
        Positioned(
          bottom: 11,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextApp(
                label: _places[_currentIndex].name,
                color: AppColors.white,
                fontSize: AppFontSize.xxxLarge,
                fontWeight: FontWeight.bold,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColors.white,
                    size: 16,
                  ),
                  TextApp(
                    label: _places[_currentIndex].location,
                    color: AppColors.white,
                    fontSize: AppFontSize.small,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
