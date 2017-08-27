// tiny parser
// $Id: TinyParser.as 165 2017-04-10 11:05:10Z Klug $
package
{
	public class TinyParser
	{
		public var s_: String;
		public var len_: int;
		public var pos_: int;
		//public static const number_char_: String = "+-.Ee";
		//public static const int_char_: String = "+-x";

		public function TinyParser()
		{}
//.............................................................................
//.............................................................................
		[Inline]
		final public function init(s: String): void
		{
			s_ = s;
			len_ = s.length;
			pos_ = 0;
		}
//.............................................................................
		[Inline]
		final public function is_Space(): Boolean
		{
			return (pos_ < len_) && (s_.charCodeAt(pos_) <= 0x20);
		}
//.............................................................................
		[Inline]
		final public function skip_Space(): void
		{
			while (pos_ < len_)
			{
				if (s_.charCodeAt(pos_) <= 0x20)
					++pos_;
				else
					break;
			}
		}
//.............................................................................
		[Inline]
		final public function find(ch: String): int
		{
			var idx: int = pos_;
			idx = s_.indexOf(ch, idx);
			if (idx < 0)
				return -1;
			pos_ = idx;
			pos_ += ch.length;
			return idx;
		}
//.............................................................................
		[Inline]
		final public function c_str(): String
		{
			return s_.substr(pos_);
		}
//.............................................................................
		public function cmp(sub: String): Boolean
		{
			var sub_len: int = sub.length;
			var i: int = 0;
			while (pos_ < len_)
			{
				if (i == sub_len)
				{
					pos_ += sub_len;
					return true;
				}
				if (s_.charCodeAt(pos_ + i) != sub.charCodeAt(i))
					break;
				++i;
			}
			return false;
		}
//.............................................................................
//.............................................................................
		public function read_Until(ch: String, toEnd: Boolean): String
		{
			var start: int = pos_;
			var end: int = find(ch);
			if (end < start)
			{
				if (!toEnd)
					return null;
				end = len_;
				pos_ = end;
			}
			return s_.substring(start, end);
		}
//.............................................................................
		public function parse_String(): String
		{
			var q: Number = s_.charCodeAt(pos_);
			var ch: String;
			if (0x22 == q)
				ch = '"';
			else if (0x27 == q)
				ch = "'";
			else
				return null;
			++pos_;
			var start: int = pos_;
			var end: int = find(ch);//:stupid but work, \" shouldn't be inside
			if (end < start)
				return null;
			return s_.substring(start, end);
		}
//.............................................................................
		public function parse_Number(): Number
		{
			var v: Number = parseFloat(s_.substr(pos_));
			//: how to jump after number? here is no strtof' endptr
			while (pos_ < len_)
			{
				if (s_.charCodeAt(pos_) > 0x20)//:stupid but work for attributes
					++pos_;
				else
					break;
			}
			return v;
		}
//.............................................................................
		public function parse_Int(): Number
		{
			var v: Number = parseInt(s_.substr(pos_));
			//: how to jump after int? here is no strtol' endptr
			while (pos_ < len_)
			{
				if (s_.charCodeAt(pos_) > 0x20)//:stupid but work for attributes
					++pos_;
				else
					break;
			}
			return v;
		}
//.............................................................................
		[Inline]
		final public function get done(): Boolean
		{
			return pos_ >= len_;
		}
//.............................................................................
	}

}