import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/responsive_scale.dart';
import '../../domain/models/model.dart';
import '../controllers/animations.dart';
import '../widgets/blinkit_logo.dart';
import '../widgets/confetti_background.dart';
import '../widgets/feature_tile.dart';
import '../widgets/gift_card_tile.dart';
import '../widgets/money_title.dart';
import '../widgets/round_icon_button.dart';

class BlinkitMoneyScreen extends StatefulWidget {
  const BlinkitMoneyScreen({super.key});

  @override
  State<BlinkitMoneyScreen> createState() => _BlinkitMoneyScreenState();
}

class _BlinkitMoneyScreenState extends State<BlinkitMoneyScreen>
    with TickerProviderStateMixin {
  late final BlinkitMoneyAnimations _animations;

  static const List<FeatureItem> _featureItems = [
    FeatureItem(
      iconAsset: AppAssets.iconSingleTap,
      title: 'Single tap payments',
      subtitle: 'Enjoy seamless payments without the wait for OTPs',
    ),
    FeatureItem(
      iconAsset: AppAssets.iconZeroFailures,
      title: 'Zero failures',
      subtitle: 'Zero payment failures ensure you never miss an order',
    ),
    FeatureItem(
      iconAsset: AppAssets.iconRealtimeRefunds,
      title: 'Real-time refunds',
      subtitle:
          'No need to wait for refunds. Blinkit Money refunds are instant!',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animations = BlinkitMoneyAnimations(vsync: this)..start();
  }

  @override
  void dispose() {
    _animations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthScale = ResponsiveScale.width(context);
    final heightScale = ResponsiveScale.height(context);
    final uiScale = ((widthScale * 0.75) + (heightScale * 0.25)).clamp(
      0.82,
      1.15,
    );

    return Scaffold(
      body: AnimatedBuilder(
        animation: _animations.merged,
        builder: (context, child) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.gradientTop,
                  Color(0xFF2A2612),
                  AppColors.gradientMid,
                  Color(0xFF121724),
                  AppColors.gradientBottom,
                ],
                stops: [0.0, 0.18, 0.46, 0.72, 1.0],
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(child: _buildTopGlow()),
                Positioned.fill(child: _buildTopDotTexture()),
                Positioned.fill(child: _buildVignette()),
                ConfettiBackground(
                  progress: _animations.confettiProgress.value,
                ),
                Positioned.fill(
                  child: SafeArea(
                    child: Column(
                      children: [
                        const SizedBox.shrink(),
                        _buildHeader(
                          uiScale: uiScale,
                          settingsOpacity:
                              _animations.staggeredItemOpacity[2].value,
                        ),
                        SizedBox(height: 84 * heightScale),
                        Transform.translate(
                          offset: Offset(
                            0,
                            (24 * heightScale) +
                                (_animations.logoTopOffsetFactor.value *
                                    MediaQuery.of(context).size.height),
                          ),
                          child: Column(
                            children: [
                              _buildAnimatedHeroLogo(context, uiScale),
                              SizedBox(height: 42 * heightScale),
                              SizedBox(
                                height: 70 * uiScale,
                                child: ClipRect(
                                  child: Transform.translate(
                                    offset: Offset(
                                      0,
                                      _animations.titleSlide.value,
                                    ),
                                    child: Opacity(
                                      opacity: _animations.titleOpacity.value,
                                      child: MoneyTitle(scale: uiScale),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox.shrink(),
                        Expanded(
                          flex: 3,
                          child: Opacity(
                            opacity: _animations.cardsOpacity.value,
                            child: _buildDetailsSection(uiScale, heightScale),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader({
    required double uiScale,
    required double settingsOpacity,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * uiScale),
      child: Row(
        children: [
          RoundIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            scale: uiScale,
          ),
          const Spacer(),
          Opacity(
            opacity: settingsOpacity,
            child: IgnorePointer(
              ignoring: settingsOpacity < 0.95,
              child: RoundIconButton(icon: Icons.settings, scale: uiScale),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedHeroLogo(BuildContext context, double uiScale) {
    return Transform.translate(
      offset: Offset(
        0,
        _animations.logoDropOffsetFactor.value *
            MediaQuery.of(context).size.height,
      ),
      child: Transform.scale(
        scale: _animations.logoScale.value,
        child: BlinkitLogo(size: 118 * uiScale),
      ),
    );
  }

  Widget _buildDetailsSection(double uiScale, double heightScale) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16 * uiScale),
      child: Column(
        children: [
          for (var i = 0; i < _featureItems.length; i++)
            _staggered(
              index: i,
              child: FeatureTile(
                iconAsset: _featureItems[i].iconAsset,
                title: _featureItems[i].title,
                subtitle: _featureItems[i].subtitle,
                scale: uiScale,
              ),
            ),
          SizedBox(height: 10 * heightScale),
          _staggered(
            index: 3,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.addMoneyButton,
                  foregroundColor: Colors.white,
                  minimumSize: Size.fromHeight(48 * uiScale),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12 * uiScale),
                  ),
                ),
                child: Text(
                  'Add Money',
                  style: TextStyle(
                    fontSize: 16 * uiScale,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10 * heightScale),
          _staggered(index: 4, child: GiftCardTile(scale: uiScale)),
          SizedBox(height: 20 * heightScale),
          Opacity(
            opacity: ((_animations.masterController.value - 0.9) / 0.1).clamp(
              0.0,
              1.0,
            ),
            child: Text(
              'Enjoy seamless\none tap payments',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white24,
                fontSize: 34 * uiScale,
                height: 0.95,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 16 * heightScale),
        ],
      ),
    );
  }

  Widget _staggered({required int index, required Widget child}) {
    return Transform.translate(
      offset: Offset(0, _animations.staggeredItemSlide[index].value),
      child: Opacity(
        opacity: _animations.staggeredItemOpacity[index].value,
        child: child,
      ),
    );
  }

  Widget _buildTopGlow() {
    return IgnorePointer(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 400,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, -0.82),
              radius: 1.35,
              colors: [AppColors.topGlow, Colors.transparent],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopDotTexture() {
    return IgnorePointer(
      child: Align(
        alignment: Alignment.topCenter,
        child: ShaderMask(
          shaderCallback: (rect) => const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.transparent],
            stops: [0.0, 1.0],
          ).createShader(rect),
          blendMode: BlendMode.dstIn,
          child: CustomPaint(
            size: const Size(double.infinity, 130),
            painter: _TopDotPatternPainter(),
          ),
        ),
      ),
    );
  }

  Widget _buildVignette() {
    return IgnorePointer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, 0.15),
            radius: 1.15,
            colors: [
              Colors.transparent,
              AppColors.vignette.withValues(alpha: 0.52),
            ],
            stops: const [0.58, 1.0],
          ),
        ),
      ),
    );
  }
}

class _TopDotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0x99B7991F);
    const spacing = 12.0;
    const radius = 1.8;

    for (double y = 0; y < size.height; y += spacing) {
      for (double x = 0; x < size.width; x += spacing) {
        final isShiftedRow = ((y / spacing).floor() % 2) == 1;
        final dx = x + (isShiftedRow ? spacing * 0.5 : 0);
        if (dx <= size.width) {
          canvas.drawCircle(Offset(dx, y), radius, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
