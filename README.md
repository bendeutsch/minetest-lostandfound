Lost and found [lostandfound]
=============================

A Minetest mod with a new mechanic for item loss after death

Version: 0.1.0

License:
  Code: LGPL 2.1 (see included LICENSE file)
  Textures: CC-BY-SA (see http://creativecommons.org/licenses/by-sa/4.0/)

Report bugs or request help on the forum topic.

Description
-----------

This is a mod for MineTest. It modifies the way inventory items are
lost on player death, or rather, how they are obtained again after
losing them. The usual method is that inventory items are dropped
or placed at the place the player died (bones mod and similar).
This allows the player to return to that place and reclaim the
lost items, if they hurry. Which is therefore what most players do.

In Lost and Found, items are "in limbo" after death. The player has
no direct way of accessing them. Instead, such lost items are
gradually "found" over time, and can be picked up at special
"lost and found" nodes.

The motivation is to encourage "backup equipment". If the player loses
an important tool (e.g. a diamond pickaxe), it now makes sense to
have a spare at home. Also, the phase after death is a bit more
relaxed, because nothing is permanently lost and nothing but patience
will bring them back.

Current behavior
----------------

A new "Lost and Found" node is introduced. At the moment, this needs
to be placed via creative inventory or otherwise cheated in; there
are no crafting recipes.

When a player dies, the "main" and "craft" inventories are cleared
into a hidden per-player inventory with size 64 (enough for two
fully laden deaths, not counting "craft"). This inventory is then
drained over time into a 16-slot inventory accessible through the
"Lost and Found" nodes.

For development, the speed of this draining is greatly increased.
In addition, a "Lost and Found debug" node is available, which shows
the "lost" inventory, but offers little interaction.

Future plans
------------

* Tune the draining proces
* Disallow placing items into the Lost and Found chests
* Implement list rings for the formspec
* An on-screen indicator when you have waiting items

Dependencies
------------

None at the moment

Installation
------------

Unzip the archive, rename the folder to to `bewarethedark` and
place it in minetest/mods/

(  Linux: If you have a linux system-wide installation place
    it in ~/.minetest/mods/.  )

(  If you only want this to be used in a single world, place
    the folder in worldmods/ in your worlddirectory.  )

For further information or help see:
http://wiki.minetest.com/wiki/Installing_Mods
