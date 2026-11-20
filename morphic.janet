(defmacro defmorph [name impl &opt parent]
  ~(upscope
     (def ,name ,impl)
     (when ,parent (table/setproto ,name ,parent))
     (defn ,(symbol "<" name ">") [bounds color]
       (table/setproto @{:bounds bounds
                         :color color
                         :submorphs @[]
                         :owner nil} ,name))))

(defmorph Morph @{:draw (fn [self canvas] (print "Drawing generic morph"))})

(defmorph RectMorph @{:draw (fn [self canvas]
                              (print "Drawing rect morph")
                              (pp self)
                              (pp canvas))}
  Morph)

(defmorph OtherMorph @{} Morph)

(def canvas @{})

(def generic-morph (<Morph> [2 2 5 5] 1))
(:draw generic-morph canvas)

(def rect-morph (<RectMorph> [0 0 3 3] 2))
(:draw rect-morph canvas)

(def other-morph (<OtherMorph> nil nil))
(:draw other-morph canvas)
