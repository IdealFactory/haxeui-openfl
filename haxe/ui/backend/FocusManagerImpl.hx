package haxe.ui.backend;

import haxe.ui.core.Component;
import haxe.ui.events.MouseEvent;
import openfl.Lib;

class FocusManagerImpl extends FocusManagerBase {
    // openfl sets stage.focus to the click target before dispatching the mouse down.
    private override function isPointerOver(c:Component, event:MouseEvent):Bool {
        var focus = Lib.current.stage.focus;
        return focus != null && (focus == c || c.contains(focus));
    }

    private override function applyFocus(c:Component) {
        super.applyFocus(c);
        if (c != null && c.hasTextInput()) {
            Lib.current.stage.focus = c.getTextInput().textField;
        } else {
            Lib.current.stage.focus = c;
        }
    }
    
    private override function unapplyFocus(c:Component) {
        super.unapplyFocus(c);
        Lib.current.stage.focus = null;
    }
}