
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';


class Extraicons {


static const String assetWind="assets/wind.svg";
static const String assetPressure="assets/pressure.svg";
static const String assetHumidity='assets/humidity.svg';

static const String assetSunny = "assets/sunny.svg";
static const String assetClear = "assets/clear_night.svg";
static const String assetMist = "assets/mist.svg";
static const String assetLiteRain = "assets/lite_rainy.svg";
static const String assetLiteSnow = "assets/lite_snowy.svg";
static const String assetModerateRain = "assets/moderate_rain.svg";
static const String assetHeavyRain = "assets/heavy_rain.svg";
static const String assetHeavyRainThunder = "assets/heavy_rain_thunder.svg";
static const String assetHeavySnow = "assets/snow.svg";
static const String assetblizzard = "assets/blizzard.svg";
static const String assetCloudy = "assets/cloudy.svg";
static const String assetwindy = "assets/windy.svg";
static const String assetThunder = "assets/thunder.svg";
static const String assetSnow = "assets/snow.svg";
static const String assetSleet = "assets/sleet.svg";
static const String assetOvercast = "assets/overcast.svg";
static const String assetIcepellets = "assets/icepellet";

  static final Widget wingSvg= new SvgPicture.asset(assetWind,height: 30.0,width: 30.0,color:Colors.black,);
  static final Widget pressureSvg= new SvgPicture.asset(assetPressure,height: 30.0,width: 30.0,color: Colors.black,);
  static final Widget humiditySvg= new SvgPicture.asset(assetHumidity,height: 30.0,width: 30.0,color: Colors.black,);

  static final Widget sunnySvg= new SvgPicture.asset(assetSunny,height: 100,width: 100);
  static final Widget clearSvg= new SvgPicture.asset(assetClear,height: 100,width: 100);
  static final Widget mistSvg= new SvgPicture.asset(assetMist,height: 100,width: 100);
  static final Widget liteRainSvg= new SvgPicture.asset(assetLiteRain,height: 100,width: 100);
  static final Widget liteSnowSvg= new SvgPicture.asset(assetLiteSnow,height: 100,width: 100);
  static final Widget moderateRainSvg= new SvgPicture.asset(assetModerateRain,height: 100,width: 100);
  static final Widget heavyRainSvg= new SvgPicture.asset(assetHeavyRain,height: 100,width: 100);
  static final Widget heavyRainThunderSvg= new SvgPicture.asset(assetHeavyRainThunder,height: 100,width: 100);
  static final Widget heavySnowSvg= new SvgPicture.asset(assetHeavySnow,height: 100,width: 100);
  static final Widget blizzardSvg= new SvgPicture.asset(assetblizzard,height: 100,width: 100);
  static final Widget cloudySvg= new SvgPicture.asset(assetCloudy,height: 100,width: 100);
  static final Widget windySvg= new SvgPicture.asset(assetwindy,height: 100,width: 100);
  static final Widget thunderSvg= new SvgPicture.asset(assetThunder,height: 100,width: 100);
  static final Widget snowSvg = new SvgPicture.asset(assetSnow, height: 100,width: 100);
  static final Widget sleetSvg = SvgPicture.asset(assetSleet, height: 100,width: 100,);
  static final Widget overcastSvg = SvgPicture.asset(assetOvercast, height: 199, width:100);
  static final Widget icePelletSvg = SvgPicture.asset(assetIcepellets, height:100,width:100);

}
