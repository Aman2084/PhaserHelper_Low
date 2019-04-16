package com
{
	import com.aman.utils.Utils;
	
	import flash.filesystem.File;

	public class CodeTool{
		
		private const Code:Array = [
			"export default class ScratchScene extends Phaser.Scene{\n",
			"		public constructor(){",
        	"		super(\"ScratchScene\");",
    		"		}\n",
			"		public preload():void{",
			"{%s}",
			"		}",
			"	",
			"		public create():void{",
			"		", 
			"		}",
			"	",
			"		public update():void{",
			"		", 
			"		}",
			"}",
		]
		
		public var imgUrl:String;
		
		public function CodeTool(){
			
		}
		
		private function getImageCode($path:String , $key:String):Array{
			var f:File = new File(imgUrl);
			var a:Array = f.getDirectoryListing();
			for (var i:int = 0; i < a.length; i++){
				f = a[i];
				if(f.isDirectory || !f.extension || !Utils.isImage(f.extension)){
					a.splice(i , 1);
					i--;
				}
			}
			
			var arr:Array = [];
			for (var j:int = 0; j < a.length; j++){
				f = a[j];
				var k:String = $key + f.name.replace("."+f.extension , "");
				var u:String = $path + f.name;
				var s:String = "		this.load.image(" +
					stringWorld(k) + " , " + stringWorld(u) + 
					");"
				arr.push(s);
			}
			return arr;
			
			function stringWorld($s:String):String{
				$s = "\"" + $s + "\""
				return $s
			}
		}
		
		
		public function getCode($path:String , $key:String):String{
			var a:Array = getImageCode($path , $key)
			if(!a.length){
				return ""
			}
			
			var s1:String = Code.join("\n");
			var s2:String = a.join("\n");
			var s:String = s1.replace("{%s}" , s2);
			return s;
		}
		
	}
}
