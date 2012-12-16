package Event
{
	import flash.events.Event;
	
	public class DeleteUser extends Event 
	{
		public static const DELETEUSER:String = "DELETEUSER";
		private var _userName:String;
		public function DeleteUser() {
			super(DELETEUSER, true);
		}
		
		public function get userName() {
			return _userName;
		}
		public function set userName(n:String) {
			_userName = n;
		}
	}
	
}