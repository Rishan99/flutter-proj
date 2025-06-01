// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/core/bloc/event/bloc_event.dart';
import 'package:moviehub/widgets/center_hint_text.dart';
import 'package:moviehub/widgets/loading_widget.dart';

class BlocBuilderView<B extends StateStreamable<S>, S, LS extends LoadedState> extends StatelessWidget {
  final Widget? loadingWidget;
  final Widget Function(BuildContext, String)? errorWidget;
  final Widget Function(BuildContext, LS) child;
  const BlocBuilderView({
    super.key,
    this.loadingWidget,
    this.errorWidget,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      builder: (context, state) {
        if (state is LoadingState) {
          return loadingWidget ?? const LoadingWidget();
        } else if (state is LoadedState) {
          return child(context, state as LS);
        } else if (state is ErrorState) {
          return errorWidget != null ? errorWidget!(context, state.message) : CenterHintText(text: state.message);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
