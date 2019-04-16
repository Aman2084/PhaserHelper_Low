package com
{
	import com.aman.event.ZEvent;
	import mx.controls.Button;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	
	public class BrowseButton extends Button
	{
		private var _file:File = new File();
		
		public function BrowseButton($label:String="")
		{
			super();
			this.label = "浏览";
			this.addEventListener(MouseEvent.CLICK , onClick);
		}
		
		private function onClick($e:MouseEvent):void{
			var str:String = this.label + "——请选取文件夹";
			_file.browseForDirectory(str);
			_file.addEventListener(Event.SELECT , onFile);
		}
		
		private function onFile($e:Event=null):void{
			var evt:ZEvent = new ZEvent(ZEvent.Selected , url);
			this.dispatchEvent(evt);
		}
		
		public function get url():String{
			return _file.nativePath;
		}
	}
}