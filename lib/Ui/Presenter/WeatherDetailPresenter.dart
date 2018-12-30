import 'package:flutter/material.dart';
import 'package:weatherapp/Utilities/extraicons_icons.dart';

class WeatherDetailPresenter {

  Widget checkWeatherCode(int code){

    switch(code){
      case 1000:return Extraicons.sunnySvg; 
      case 1003:return Extraicons.cloudySvg;
      case 1006:return Extraicons.cloudySvg; 
      case 1009:return Extraicons.cloudySvg; 
      case 1063:return Extraicons.liteRainSvg; 
      case 1066:return Extraicons.liteSnowSvg; 
      case 1030:return Extraicons.mistSvg; 

      case 1069:return Extraicons.sunnySvg; 
      case 1072:return Extraicons.liteRainSvg; 
      case 1087:return Extraicons.thunderSvg; 

      case 1114:return Extraicons.snowSvg; 
      case 1007:return Extraicons.blizzardSvg; 
      case 1135:return Extraicons.cloudySvg; 
      case 1147:return Extraicons.cloudySvg; 

      case 1150:return Extraicons.liteRainSvg; 
      case 1153:return Extraicons.liteRainSvg; 
      case 1168:return Extraicons.liteRainSvg; 
      case 1171:return Extraicons.heavyRainSvg; 
      case 1180:return Extraicons.liteRainSvg; 
      case 1183:return Extraicons.liteRainSvg; 
      case 1186:return Extraicons.moderateRainSvg; 
      case 1189:return Extraicons.moderateRainSvg; 
      case 1192:return Extraicons.heavyRainSvg; 
      case 1195:return Extraicons.heavyRainSvg; 
      case 1198:return Extraicons.liteRainSvg; 
      case 1201:return Extraicons.moderateRainSvg; 
      case 1204:return Extraicons.sleetSvg; 
      case 1207:return Extraicons.sleetSvg; 
      case 1210:return Extraicons.liteSnowSvg; 
      case 1213:return Extraicons.liteSnowSvg; 
      case 1216:return Extraicons.liteSnowSvg;
      case 1219:return Extraicons.liteSnowSvg; 
      case 1222:return Extraicons.heavySnowSvg; 
      case 1225:return Extraicons.heavySnowSvg; 
      case 1237:return Extraicons.icePelletSvg;
      case 1240:return Extraicons.liteRainSvg; 
      case 1243:return Extraicons.moderateRainSvg; 
      case 1246:return Extraicons.heavyRainSvg; 
      case 1249:return Extraicons.cloudySvg; 
      case 1252:return Extraicons.sleetSvg; 
      case 1255:return Extraicons.heavySnowSvg;   
      case 1258:return Extraicons.heavySnowSvg; 
      case 1261:return Extraicons.liteSnowSvg; 
      case 1264:return Extraicons.heavySnowSvg; 
      case 1273:return Extraicons.liteRainSvg; 
      case 1276:return Extraicons.heavyRainThunderSvg;
      case 1279:return Extraicons.liteSnowSvg; 
      case 1282:return Extraicons.snowSvg; 
       
    }
    return Extraicons.sunnySvg;
  }
}