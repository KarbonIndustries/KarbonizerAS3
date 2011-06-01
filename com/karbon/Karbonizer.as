/*
Created by Shammel Lee on 2010-08-15.
Copyright (c) 2010 Karbon, Inc. All rights reserved.
*/

package com.karbon
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.ui.*;
	import flash.net.*;
	
	
	public class Karbonizer
	{
		/* ================================= */
		/* = CONSTANTS + GETTERS + SETTERS = */
		/* ================================= */
		
		private static const COMPANY:String =				'Karbon Inc.';

		// KEY CODES
		private static const KEY_CODES:Object = 
		{
			A:									65,
			B:									66,
			C:									67,
			D:									68,
			E:									69,
			F:									70,
			G:									71,
			H:									72,
			I:									73,
			J:									74,
			K:									75,
			L:									76,
			M:									77,
			N:									78,
			O:									79,
			P:									80,
			Q:									81,
			R:									82,
			S:									83,
			T:									84,
			U:									85,
			V:									86,
			W:									87,
			X:									88,
			Y:									89,
			Z:									90,
			STD_ZERO:							48,
			STD_ONE:							49,
			STD_TWO:							50,
			STD_THREE:							51,
			STD_FOUR:							52,
			STD_FIVE:							53,
			STD_SIX:							54,
			STD_SEVEN:							55,
			STD_EIGHT:							56,
			STD_NINE:							57,
			NUM_ZERO:							96,
			NUM_ONE:							97,
			NUM_TWO:							98,
			NUM_THREE:							99,
			NUM_FOUR:							100,
			NUM_FIVE:							101,
			NUM_SIX:							102,
			NUM_SEVEN:							103,
			NUM_EIGHT:							104,
			NUM_NINE:							105,
			MULTIPLY:							106,
			ADD:								107,
			ENTER:								13,
			SUBTRACT:							109,
			DECIMAL:							110,
			DIVIDE:								111,
			F1:									112,
			F2:									113,
			F3:									114,
			F4:									115,
			F5:									116,
			F6:									117,
			F7:									118,
			F8:									119,
			F9:									120,
			F11:								122,
			F12:								123,
			F13:								124,
			F14:								125,
			F15:								126,
			BACKSPACE:							8,
			TAB:								9,
			ENTER:								13,
			SHIFT:								16,
			CONTROL:							17,
			CAPS_LOCK:							20,
			ESC:								27,
			SPACEBAR:							32,
			PAGE_UP:							33,
			PAGE_DOWN:							34,
			END:								35,
			HOME:								36,
			LEFT:								37,
			UP:									38,
			RIGHT:								39,
			DOWN:								40,
			INSERT:								45,
			DELETE:								46,
			NUM_LOCK:							144,
			SCR_LOCK:							145,
			PAUSE_BREAK:						19,
			COLON:								186,
			PLUS_MINUS:							187,
			HYPEN_UNDERSCORE:					189,
			FORWARD_SLASH_QUESTION:				191,
			TILDE_BACKQUOTE:					192,
			LEFT_BRACE_BRACKET:					219,
			BACK_SLASH_PIPE:					220,
			RIGHT_BRACE_BRACKET:				221,
			QUOTE:								222,
			COMMA:								188,
			PERIOD:								190
		};

		public static function get COMPANY_NAME():String
		{
			return COMPANY;
		}

		public static function get KEYS():Object
		{
			return KEY_CODES;
		}

		/* ========== */
		/* = EVENTS = */
		/* ========== */
		
		public static const VIDEO_EVENT:Object = 
		{
			PLAYING:'playing',
			PAUSED:'paused',
			STOPPED:'stopped',
			COMPLETE:'videoComplete',
			TIME_UPDATE:'timeUpdate',
			SCRUBBING:'scrubbing'
		};
		


		/* =============== */
		/* = ECHO METHOD = */
		/* =============== */
		
		private static var ECHO_ENABLED:Boolean =			true;
		
		public static function echo(exp:*):void
		{
			trace(ECHO_ENABLED ? exp : 'Karbonizer.echo is not enabled!');
		}
		
		public static function set echoEnabled(v:Boolean):void
		{
			ECHO_ENABLED = v;
		}
		
		
		/* ====================== */
		/* = COORDINATE METHODS = */
		/* ====================== */
		
		public static function centerTo(o1:Object,o2:Object,h:Boolean = true,v:Boolean = true):void
		{
			h ? o1.x = getCenter(o2).x - (o1.width/2) : void;
			v ? o1.y = getCenter(o2).y - (o1.height/2) : void;
		}
		
		public static function getCenter(o:Object):Point
		{
			return new Point(o.x + (o.width/2),o.y + (o.height/2));
		}

		public static function alignLeft(o1:Object,o2:Object,alignLeftOffset:Number = 0):void
		{
			o1.x = o2.x + alignLeftOffset;
		}

		public static function alignRight(o1:Object,o2:Object,alignRightOffset:Number = 0):void
		{
			if(o2 is Stage)
			{
				o1.x = o2.x + o2.stageWidth - o1.width + alignRightOffset;
			}else
			{
				o1.x = o2.x + o2.width - o1.width + alignRightOffset;
			}
		}

		public static function alignTop(o1:Object,o2:Object,alignTopOffset:Number = 0):void
		{
			o1.y = o2.y + alignTopOffset;
		}

		public static function alignBottom(o1:Object,o2:Object,alignBottomOffset:Number = 0):void
		{
			if(o2 is Stage)
			{
				o1.y = o2.y + o2.stageHeight - o1.height + alignBottomOffset;
			}else
			{
				o1.y = o2.y + o2.height - o1.height + alignBottomOffset;
			}
		}

		public static function getRight(o:DisplayObject,round:Boolean = false):Number
		{
			return round ? Math.round(o.x + o.width) : o.x + o.width;
		}
		
		public static function getBottom(o:DisplayObject,round:Boolean = false):Number
		{
			return round ? Math.round(o.y + o.height) : o.y + o.height;
		}
		
		public static function zeroToNCoordinates(curPos:Point,area:Rectangle,n:Number = 1,abs:Boolean = false,round:Boolean = false):Point
		{
			var maxDist:Point = new Point(area.width/2,area.height/2);
			var curDist:Point = curPos.subtract(maxDist);
			var pointX:Number = abs ? Math.abs((curDist.x/maxDist.x) * n) : (curDist.x/maxDist.x) * n;
			var pointY:Number = abs ? Math.abs((curDist.y/maxDist.y) * n) : (curDist.y/maxDist.y) * n;
			pointX = round ? Math.round(pointX) : pointX;
			pointY = round ? Math.round(pointY) : pointY;
			
			return new Point(pointX,pointY);
		}

		public static function flipZeroToN(curPos:Point,maxPos:Point):Point
		{
			return Point(maxPos.subtract(curPos));
		}
		
		
		/* ================ */
		/* = MATH METHODS = */
		/* ================ */
		
		public static function getPercent(dividend:Number,divisor:Number,round:Boolean = false):Number
		{
			var quotient:Number = dividend/divisor * 100;
			return round ? Math.round(quotient) : quotient;
		}
		
		public static function getLoadValue(_loaded:Number,_total:Number,_max:Number,_round:Boolean):Number
		{
			return _round ? Math.round((_loaded/_total) * _max) : (_loaded/_total) * _max;
		}
		
		public static function getScrollPosition(thumbPos:Number,thumbMax:Number,trackMax,objectMax:Number,maskMax:Number):Number
		{
			return -((thumbPos/(trackMax - thumbMax)) * (objectMax - maskMax));
		}


		public static function greaterLess(val:Number,min:Number,max:Number,eMin:Boolean = false,eMax:Boolean = false):Boolean
		{
			if(eMin && eMax)
			{return (val >= min && val <= max);}
			if(!eMin && !eMax)
			{return (val > min && val < max);}
			if(eMin && !eMax)
			{return (val >= min && val < max);}
			if(!eMin && eMax)
			{return (val > min && val <= max);}
			return false;
		}

		/* ================= */
		/* = ARRAY METHODS = */
		/* ================= */
		
		public static function getOffsetIndex(index:uint,offset:int,a:Array):uint
		{
			var rIndex:uint;
			var v:int = index + offset;
			(v >= 0 && v <= a.length - 1) ? rIndex = v : void;
			v < 0 ? rIndex = a.length + v : void;
			v > a.length - 1 ? rIndex = v - a.length: void;

			return rIndex;
		}
		
		public static function getObjectWithValue(_property:String,_value:*,_object:Object):Object
		{
			var obj:Object;
			for each(var i:Object in _object)
			{
				if(i.hasOwnProperty(_property) && i[_property] == _value)
				{
					obj = i
					break;
				}
			}

			return obj;
		}

		public static function getObjectsWithValue(_property:String,_value:*,_object:Object):Array
		{
			var a:Array = new Array();
			for each(var i:Object in _object)
			{
				if(i.hasOwnProperty(_property) && i[_property] == _value)
				{
					a.push(i);
				}
			}

			return a;
		}

		public static function getObjectsWithoutValue(_property:String,_value:*,_object:Object):Array
		{
			var a:Array = new Array;
			for each(var i:Object in _object)
			{
				if(i.hasOwnProperty(_property) && i[_property] != _value)
				{
					a.push(i);
				}
			}

			return a;
		}

		public static function getObjectsWithProperty(_property:String,_object:Object):Array
		{
			var a:Array = new Array;
			for each(var i:Object in _object)
			{
				i.hasOwnProperty(_property) ? a.push(i) : void;
			}

			return a;
		}

		public static function getObjectsWithoutProperty(_property:String,_object:Object):Array
		{
			var a:Array = new Array;
			for each(var i:Object in _object)
			{
				!i.hasOwnProperty(_property) ? a.push(i) : void;
			}

			return a;
		}

		/* ====================== */
		/* = CONVERSION METHODS = */
		/* ====================== */
		
		public static function hexStrToNum(v:String):uint
		{
			return v.length == 6 ? uint('0x' + v) : 0;
		}
		
		public static function numToHexStr(v:Number,addPrefix:Boolean = false):String
		{
			return addPrefix ? '0x' + v.toString(16).toUpperCase() : v.toString(16).toUpperCase();
		}

		public static function getScrollPercent():Number
		{
			return NaN;
		}


		/* ====================== */
		/* = VALIDATION METHODS = */
		/* ====================== */
		
		public static function isEmpty(v:String):Boolean
		{
			return (v == '' || v == ' ') ? true : false;
		}
		
		public static function isSet(v:*):Boolean
		{
			return (v == null || v == undefined || v <= 0) ? false : true;
		}
		
		/* ================== */
		/* = CREDIT METHODS = */
		/* ================== */
		
		private static var credit:ContextMenuItem;
		private static var clientItem:ContextMenuItem;
		private static var c:XML;
		private static var creditLink:String;
		private static var siteId:uint;
		private static var cm:ContextMenu;
		private static var _stage:*;
		
		public static function loadCredits(url:String,id:uint,obj:*):void
		{
			cm = new ContextMenu();
			cm.hideBuiltInItems();
			_stage = obj;
			siteId = id;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,creditsLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR,creditsError);
			loader.load(new URLRequest(url));
		}
		
		private static function creditsLoaded(e:Event):void
		{
			var data:XML = XML(e.target.data);
			c = XML(data.credit.(@id == siteId));
			creditLink = c.@authorURL;
			credit = new ContextMenuItem(c.@authorTitle);
			credit.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,gotoAuthorURL);
			clientItem = new ContextMenuItem('© ' + new Date().getFullYear() + ' ' + c.@clientName,true);
			cm.customItems.push(credit,clientItem);
			_stage.contextMenu = cm;
		}
		
		private static function creditsError(e:IOErrorEvent):void
		{
			creditLink = 'http://www.google.com/#q=Karbon%20Interaktive%20Inc.%20%22Shammel%20Lee%22';
			credit = new ContextMenuItem(':: site by ' + COMPANY + ' ::');
			credit.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,gotoAuthorURL);
			cm.customItems.push(credit);
			_stage.contextMenu = cm;
		}
		
		private static function gotoAuthorURL(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest(creditLink),'_blank');
		}
	}
}