package 
{
	import flash.display.Sprite;
	import Event.*;
	public class ClientObj extends Sprite 
	{
		private var createAllUserEvent = new CreatAllUser();
		private var createUserEvent = new CreatUser();
		private var deleteUserEvent = new DeleteUser();
		public function ClientObj() {
			
		}
		
		public function creatAllUser(userNameArray:Array) {
			createAllUserEvent.allUserArr = userNameArray;
			dispatchEvent(createAllUserEvent);
		}
		
		public function creatUser(userName:String) {
			createUserEvent.userName = userName;
			dispatchEvent(createUserEvent);
		}
		
		public function deleteUser(userName:String) {
			deleteUserEvent.userName = userName;
			dispatchEvent(deleteUserEvent);
		}
		
	}
	
}