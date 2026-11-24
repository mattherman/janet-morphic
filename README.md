An attempt at creating a Morphic UI framework in Janet.

Inspired by https://www.inkandswitch.com/livelymerge/notebook/lm-06/.

# Morphs

"Morph" is Greek for _shape_. Every visible thing is a morph. Morphs are composed of other morphs. For example, a window is a morph, the title bar is a morph, the scroll bar and its individual buttons are morphs. The root of this tree is the World morph. I see this as similar to a hierarchy of UI components like React, but what we can do with morphs is where it differs.

Each morph is directly editable in the live running system. There are no properties or editors - you are modifying the live object.

The tree of morphs also synchronizes itself by positioning each submorph relative to its parent, or owner. If you resize the owner, its submorphs will also resize.

## Drawing & Events

Morphs draw themselves and then draw their children in order so submorphs are drawn on top of those higher in the hierarchy.

Events are handled in the opposite direction. For example, a click event will first be offered to the top morph. If it declines to handle it, the event travels up the tree similar to "bubbling" in web browsers.

Even the pointer is a morph. Dragging elements is as simple as re-parenting the grabbed morph under the pointer morph so it adjusts its position relative to the pointer.

## Halos

Morphic traditionally has the concept of a "halo" for interacting with elements. Meta-clicking on any morph provides handles for things like deletion, moving, resizing, rotating, and duplicating.

The most interesting handle is for the inspector. This allows you to open a window for viewing the morph and editing its code.

## Liveness

Liveness is handled through stepping. This is essentially an event system for each morph where they can define an interval on which to _step_. They execute a stepping function when that interval happens to update their state or perform some other operation.

## Composition

The tree allows you to freely compose morphs. You don't need to define an `IconButton` ahead of time. You can create an icon morph and simply add it to a button morph as a child.