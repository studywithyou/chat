package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldType;
	import flash.text.TextField;
	
	/**
	 * FMS聊天室
	 * @author winterIce
	 */
	[SWF(width = "800", height = "600", frameRate = "60", backgroundColor = "0xffffff")]
	public class Main extends Sprite 
	{
		private var client:ChatClient;
		private var input:TextField;
		private var label:TextField;
		private var login_btn;
		public function Main():void 
		{
			label = new TextField();
			label.text = "用户名:";
			label.x = 150;
			label.y = 200;
			addChild(label);
			
			input = new TextField();
			input.type = TextFieldType.INPUT;
			input.width = 100;
			input.height = 20;
			input.x = 200;
			input.y = 200;
			input.background = true;
			input.border = true;
			addChild(input);
			
			login_btn = new loginBtn();
			login_btn.x = 220;
			login_btn.y = 240;
			addChild(login_btn);
			login_btn.addEventListener(MouseEvent.MOUSE_UP, creatClient);
		}
		private function creatClient(evt:MouseEvent) {
			removeChild(label);
			removeChild(input);
			removeChild(login_btn);
			removeEventListener(MouseEvent.MOUSE_UP, creatClient);
			client = new ChatClient(input.text);
			addChild(client);
		}
		
	}
	
}