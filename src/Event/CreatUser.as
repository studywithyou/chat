package Event
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author winterIce
	 */
	public class CreatUser extends Event 
	{
		public static const CREATUSER = "CREATUSER";
		private var _userName:String;
		public function CreatUser() {
			super(CREATUSER, true);
		}
		
		public function get userName() {
			return _userName;
		}
		public function set userName(n:String) {
			_userName = n;
		}
	}
	
}