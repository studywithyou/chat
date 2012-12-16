package 
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.net.NetConnection;
    import flash.net.ObjectEncoding;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	import flash.events.NetStatusEvent;
	import flash.events.SyncEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import Event.*;
	
	public class ChatClient extends Sprite 
	{
		private var _conn:NetConnection;
		private var _rtmp:String = "rtmp://localhost/chat";
		private var _myObj:ClientObj;
		private var _so:SharedObject;
		private var _chatContainer:TextField;
		private var _userList:TextField;
		private var _inputFrame:TextField;
		private var _myname:String;
		
		private var allUserList:Array=new Array();//所有用户
		
		public function ChatClient(myname:String) {
			//addEventListener(DisConnectEvent.DIS_CONNECT,deleteUser);
			//addEventListener(LinkCompleteEvent.LINK_COMPLETE,createMapOrUser);
			//addEventListener(NewRoadEvent.NEW_ROAD,updateRoad);
			//addEventListener(ChangeMapEvent.CHANGE_MAP,disConnect);
			//addEventListener(SoEvent.SO_SYNC,viewChat);
		    this._myname = myname;
			
			initUI();
			initFMS();
			addEventListener(CreatAllUser.CREATALLUSER, renderAllUser);
			addEventListener(CreatUser.CREATUSER, renderUser);
			addEventListener(DeleteUser.DELETEUSER, deleteUser);
		}
		public function initUI() {
			//聊天内容
			_chatContainer = new TextField();
			_chatContainer.width = 300;
			_chatContainer.height = 300;
			_chatContainer.background = true;
			_chatContainer.backgroundColor = 0xff0000;
			addChild(_chatContainer);
			//用户列表
			_userList = new TextField();
			_userList.width = 100;
			_userList.height = 300;
			_userList.x = 320;
			_userList.y = 0;
			_userList.background = true;
			_userList.backgroundColor = 0xffcccc;
			addChild(_userList);
			//输入框
			_inputFrame = new TextField();
			_inputFrame.width = 300;
			_inputFrame.height = 100;
			_inputFrame.x = 0;
			_inputFrame.y = 320;
			_inputFrame.background = true;
			_inputFrame.backgroundColor = 0xffffcc;
			_inputFrame.type = TextFieldType.INPUT;
			addChild(_inputFrame);
			//发送按钮
			var btn = new sendBtn();
			btn.x = 320;
			btn.y = 320;
			addChild(btn);
			btn.addEventListener(MouseEvent.CLICK, send);
		}
		public function initFMS() {
			_conn=new NetConnection();
			_myObj=new ClientObj();
			addChild(_myObj);
			_conn.client=_myObj;
			_conn.objectEncoding=ObjectEncoding.AMF0;
			_conn.connect(_rtmp,this._myname);
			_conn.addEventListener(NetStatusEvent.NET_STATUS,NetStatusEventHandel);
		}
		public function NetStatusEventHandel(evt:NetStatusEvent) {
			var s:String=evt.info.code;
			if (s=="NetConnection.Connect.Success") {
				init_so();
			}
		}
		
		private function init_so() {
			_so=SharedObject.getRemote("user", _conn.uri, false);
			_so.connect(_conn);
			_so.addEventListener(SyncEvent.SYNC, syncHandle);
		}
		public function send(evt:MouseEvent) {
			var o = new Object();
			o.name = this._myname;
			o.chat = _inputFrame.text;
			o.time = new Date().getFullYear()+'.'+(new Date().getMonth()+1)+'.'+new Date().getDate()+' '+new Date().getHours()+':'+new Date().getMinutes()+':'+new Date().getSeconds();
			_so.setProperty("content", o);
			_inputFrame.text = "";
		}
		
		public function syncHandle(evt:SyncEvent) {
			if(_so.data.content){
		        _chatContainer.appendText(_so.data.content.name +'   '+ _so.data.content.time+'\n' + _so.data.content.chat+'\n');
		    }
		}
		
		private function renderAllUser(evt:CreatAllUser) {
			allUserList = evt.allUserArr;
			showUser();
		}
		
		private function renderUser(evt:CreatUser) {
			allUserList.push(evt.userName);
			showUser();
		}
		
		private function deleteUser(evt:DeleteUser) {
			for (var i = 0, len = allUserList.length; i < len; i++ ) {
				if (allUserList[i] == evt.userName) {
					allUserList.splice(i, 1);
					break;
				}
			}
			showUser();
		}
		
		private function showUser() {
			_userList.text = "用户列表\n";
			_userList.appendText(allUserList.join('\n'));
		}
	}
	
}