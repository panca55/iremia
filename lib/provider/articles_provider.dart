import 'package:flutter/material.dart';
import 'package:iremia/models/articles_model.dart';
import 'package:iremia/theme/global_color_theme.dart';

class ArticlesProvider extends ChangeNotifier {
   final List<ArticlesModel> _articles = [
    ArticlesModel(
      id:1,
      title: 'Artikel 1',
      content: '''  Lorem  ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod  tempor incididunt ut labore et dolore magna aliqua. Lobortis scelerisque  fermentum dui faucibus in ornare quam. Ultrices mi tempus imperdiet  nulla malesuada. Sagittis vitae et leo duis ut. Tempor orci dapibus  ultrices in. Feugiat pretium nibh ipsum consequat nisl. Eu scelerisque  felis imperdiet proin fermentum.
  Egestas fringilla phasellus faucibus scelerisque eleifend donec  pretium vulputate sapien. Diam phasellus vestibulum lorem sed risus  ultricies tristique. Orci ac auctor augue mauris augue neque gravida in.  Leo duis ut diam quam nulla porttitor massa. Turpis nunc eget lorem  dolor sed viverra ipsum nunc. Massa enim nec dui nunc mattis enim ut  tellus. Maecenas sed enim ut sem. ''', 
      image: '', 
      color: GlobalColorTheme.itemListColor, 
      author: 'Author', 
      publish: '2019'
    ),
    ArticlesModel(
      id: 2,
      title: 'Artikel 2', 
      content: '''  Lorem  ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod  tempor incididunt ut labore et dolore magna aliqua. Lobortis scelerisque  fermentum dui faucibus in ornare quam. Ultrices mi tempus imperdiet  nulla malesuada. Sagittis vitae et leo duis ut. Tempor orci dapibus  ultrices in. Feugiat pretium nibh ipsum consequat nisl. Eu scelerisque  felis imperdiet proin fermentum.
  Egestas fringilla phasellus faucibus scelerisque eleifend donec  pretium vulputate sapien. Diam phasellus vestibulum lorem sed risus  ultricies tristique. Orci ac auctor augue mauris augue neque gravida in.  Leo duis ut diam quam nulla porttitor massa. Turpis nunc eget lorem  dolor sed viverra ipsum nunc. Massa enim nec dui nunc mattis enim ut  tellus. Maecenas sed enim ut sem. ''', 
      image: '', 
      color: GlobalColorTheme.successColor,
      author: 'Author', 
      publish: '2019'
    ),
    ArticlesModel(
      id: 3,
      title: 'Artikel 3', 
      content: '''  Lorem  ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod  tempor incididunt ut labore et dolore magna aliqua. Lobortis scelerisque  fermentum dui faucibus in ornare quam. Ultrices mi tempus imperdiet  nulla malesuada. Sagittis vitae et leo duis ut. Tempor orci dapibus  ultrices in. Feugiat pretium nibh ipsum consequat nisl. Eu scelerisque  felis imperdiet proin fermentum.
  Egestas fringilla phasellus faucibus scelerisque eleifend donec  pretium vulputate sapien. Diam phasellus vestibulum lorem sed risus  ultricies tristique. Orci ac auctor augue mauris augue neque gravida in.  Leo duis ut diam quam nulla porttitor massa. Turpis nunc eget lorem  dolor sed viverra ipsum nunc. Massa enim nec dui nunc mattis enim ut  tellus. Maecenas sed enim ut sem. ''', 
      image: '', 
      color: GlobalColorTheme.errorColor,
      author: 'Author', 
      publish: '2019'
    ),
    ArticlesModel(
      id: 4,
      title: 'Artikel 4', 
      content: '''  Lorem  ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod  tempor incididunt ut labore et dolore magna aliqua. Lobortis scelerisque  fermentum dui faucibus in ornare quam. Ultrices mi tempus imperdiet  nulla malesuada. Sagittis vitae et leo duis ut. Tempor orci dapibus  ultrices in. Feugiat pretium nibh ipsum consequat nisl. Eu scelerisque  felis imperdiet proin fermentum.
  Egestas fringilla phasellus faucibus scelerisque eleifend donec  pretium vulputate sapien. Diam phasellus vestibulum lorem sed risus  ultricies tristique. Orci ac auctor augue mauris augue neque gravida in.  Leo duis ut diam quam nulla porttitor massa. Turpis nunc eget lorem  dolor sed viverra ipsum nunc. Massa enim nec dui nunc mattis enim ut  tellus. Maecenas sed enim ut sem. ''', 
      image: '', 
      color: GlobalColorTheme.itemListColor,
      author: 'Author', 
      publish: '2019'
    ),
  ];
  List<ArticlesModel> get articleList => _articles;
  int _selectedArticle = -1;

  int get selectedArticle => _selectedArticle;

  void setSelectedArticle(int index) {
    _selectedArticle = index;
    notifyListeners();
  }
}
