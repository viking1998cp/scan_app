import 'dart:async';

import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  FavoriteButton({
    double? iconSize,
    Color? iconColor,
    Color? iconDisabledColor,
    bool? isFavorite,
    required Function valueChanged,
    Key? key,
  })  : _iconSize = iconSize ?? 60.0,
        _iconColor = iconColor ?? Colors.red,
        _iconDisabledColor = iconDisabledColor ?? Colors.grey[400]!,
        _isFavorite = isFavorite ?? false,
        _valueChanged = valueChanged,
        super(key: key);

  final double _iconSize;
  final Color _iconColor;
  final bool _isFavorite;
  final Function _valueChanged;
  final Color _iconDisabledColor;

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  // ignore: unused_field
  Animation<Color?>? _colorAnimation;
  Animation<double?>? _sizeAnimation;

  CurvedAnimation? _curve;

  double _maxIconSize = 0.0;
  double _minIconSize = 0.0;

  final int _animationTime = 400;

  bool? _isFavorite = false;
  bool? _isAnimationCompleted = false;
  Animation<Color?>? _selectedColorAnimation;
  Animation<Color?>? _deSelectedColorAnimation;
  bool onClick = false;
  @override
  void initState() {
    super.initState();

    _maxIconSize = (widget._iconSize < 20.0)
        ? 20.0
        : (widget._iconSize > 100.0)
            ? 100.0
            : widget._iconSize;
    final double _sizeDifference = _maxIconSize * 0.30;
    _minIconSize = _maxIconSize - _sizeDifference;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _animationTime),
    );

    _curve = CurvedAnimation(curve: Curves.slowMiddle, parent: _controller!);

    _controller!.addStatusListener((status) {
      setState(() {
        onClick = true;
        if (status == AnimationStatus.completed) {
          _isAnimationCompleted = true;
          _isFavorite = !_isFavorite!;
          widget._valueChanged(_isFavorite);
        } else if (status == AnimationStatus.dismissed) {
          _isAnimationCompleted = false;
          _isFavorite = !_isFavorite!;
          widget._valueChanged(_isFavorite);
        }
        Timer(Duration(milliseconds: 500), () {
          onClick = false;
        });
      });
    });

    _selectedColorAnimation = ColorTween(
      begin: widget._iconColor,
      end: widget._iconDisabledColor,
    ).animate(_curve!);

    _deSelectedColorAnimation = ColorTween(
      begin: widget._iconDisabledColor,
      end: widget._iconColor,
    ).animate(_curve!);
    _colorAnimation =
        (_isFavorite!) ? _selectedColorAnimation : _deSelectedColorAnimation;
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!onClick) {
      _isFavorite = widget._isFavorite;
    }
    _sizeAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: _minIconSize,
            end: _maxIconSize,
          ),
          weight: 50,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: _maxIconSize,
            end: _minIconSize,
          ),
          weight: 50,
        ),
      ],
    ).animate(_curve!);
    return AnimatedBuilder(
      animation: _controller!,
      builder: (BuildContext context, _) {
        return InkResponse(
          onTap: () {
            setState(() {
              if (_isAnimationCompleted == true) {
                _controller!.reverse();
              } else {
                _controller!.forward();
              }
            });
          },
          child: Icon(
            (_isFavorite! ? Icons.favorite : Icons.favorite_border_outlined),
            color: _isFavorite! ? widget._iconColor : widget._iconDisabledColor,
            size: _sizeAnimation!.value,
          ),
        );
      },
    );
  }
}
