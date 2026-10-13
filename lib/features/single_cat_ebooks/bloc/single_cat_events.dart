part of 'single_cat_bloc.dart';

abstract class SingleCatEvents {}

class LoadCatPost extends SingleCatEvents {
  final int catId;
  LoadCatPost(this.catId);
}
