(def Morph @{:draw (fn [self canvas] (print "Drawing Morph"))
             :draw-all (fn [self canvas]
                         (:draw self canvas)
                         (each submorph (self :submorphs)
                           (:draw-all submorph canvas)))
             :add-child (fn [self child]
                          # TODO: Remove the child from its current owner if it has one
                          (array/push (self :submorphs) child)
                          (set (child :owner) self))})

(defn make-morph [morph-type &opt impl]
  (def morph (merge @{:submorphs @[]} (default impl @{})))
  (table/setproto morph morph-type)
  morph) 

(def RectMorph (make-morph Morph @{:draw (fn [self canvas]
                 (printf "Drawing RectMorph, bounds: %q color: %x" (self :bounds) (self :color)))
         :bounds [0 0 10 10]
         :color 0xFF0000}))

(def outer (make-morph RectMorph @{ :bounds [0 0 100 100] :color 0x00FF00 }))
(def inner (make-morph RectMorph @{ :bounds [10 10 80 80] :color 0x0000FF }))

(:add-child outer inner)

(def world (make-morph Morph))
(:add-child world outer)
(def canvas @{})

(:draw-all world canvas)
