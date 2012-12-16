package Event
{
	import flash.events.Event;
	public class CreatAllUser extends Event 
	{
		public static const CREATALLUSER:String = "CREATALLUSER";
		private var _allUserArr:Array;
		public function CreatAllUser() {
			super(CREATALLUSER, true);
		}
		public function get allUserArr() {
			return _allUserArr;
		}
		public function set allUserArr(a:Array) {
			_allUserArr = a;
		}
	}
	
}