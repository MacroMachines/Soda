Soda.Selector = class(Soda.Button) --press deactivates its siblings

function Soda.Selector:touched(t, tpos)
    if t.state == BEGAN then
        if self:pointIn(tpos.x, tpos.y) then
            self.touchId = t.id
            self:keyboardHideCheck()
           -- self.highlighted = true
            return true
        end
    elseif self.touchId and self.touchId == t.id then
        if t.state == MOVING then
            if not self:pointIn(tpos.x, tpos.y) then --cancelled
                self.touchId = nil
              --  self.highlighted = false
                return true
            end
        else --ended
            self.callback()
            self.touchId = nil
          --  self.on = true
            self.highlighted = true
            self.parent:selectFromList(self)
            return true
        end
    end
    return Soda.Frame.touched(self, t, tpos) 
end