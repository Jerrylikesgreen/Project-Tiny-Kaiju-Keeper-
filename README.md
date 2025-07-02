# **Project:**

# **Tiny Kaiju Keeper – Jam‑Scope GDD (v 1.1)**

---

## **1\. High‑Concept (Bite‑Size)**

“Raise a baby kaiju in your browser or on Windows. Feed, clean, and play—your choices forge either a benevolent sky guardian (*Mothlyn*) or a city‑stomping titan (*Gigazilla*).”

---

## **2\. Scope & Constraints**

| Constraint | Jam‑Friendly Decision |
| :---- | :---- |
| **Jam Length** | 10 days (hard stop) |
| **Team Size** | 3 core members |
| **Platforms** | Web (HTML5) & Windows |
| **Palette** | Fixed 4‑to‑6 colors (may fall back to full monochrome) |
| **Core Mini‑Game** | **Sky Flutter** – tap/space to keep *Mini‑Kaiju* airborne |
| **Wishlist Mini‑Games** | • **City Stomp** (rhythm) • **Memory Match** (tile flip) — only if time permits |
| **Monetization** | None for jam, but the codebase keeps a disabled **Shop** scene \+ DLC tables to showcase F2P readiness |
| **Marketing** | Single launch tweet \+ itch.io page; focus is portfolio quality |

## ---

## **3\. Core Pillars**

1. **Nurture Loop** – Feed, Clean, Play (1 mini‑game).

2. **Branching Evolution** – 3 stages → final forms *Mothlyn* (guardian) or *Gigazilla* (titan).

3. **Fixed‑Palette Charm** – Cohesive, limited‑color art direction.

---

## **4\. Gameplay Loop (Minute‑to‑Minute)**

`Open Game → Check Stats →`

`Choose Action (Feed / Clean / Play) →`

`Stat Change & Animation →`

`Idle Timer / Close Game`

*Idle Drain:* Stats tick down every real‑time hour (LocalStorage / JSON save).  
 *Notification:* Browser favicon pulse only (no push).

---

## **5\. Stats & Evolution (Simplified)**

| Stat | Drain | Player Fix | Notes |
| ----- | ----- | ----- | ----- |
| **Hunger** | −1 every 2 hrs | Feed snacks | Overfeed bias → *Gigazilla* |
| **Hygiene** | Event‑based (“Poop”) | Swipe clean | High hygiene bias → *Mothlyn* |
| **Happiness** | −1 every 3 hrs | Play mini‑game | Affects color variant |

**72‑Hour Evolution Check**

* Avg Hygiene ≥ 80 % → **Mothlyn Path**

* Else if Avg Hunger ≥ 80 % → **Gigazilla Path**

* Else 50 / 50 random.


---

## **7\. Tool / Tech Stack**

| Purpose | Tool |
| ----- | ----- |
| **Engine & Export** | **Godot 4.x** (HTML5 & Windows) |
| **Version Control** | **GitHub** repo |
| **Graphics** | **Aseprite** |
| **SFX Generator** | **Bfxr** |
| **Project Management** | **Trello** (Backlog → Working → Review → Done) |
| **Comms** | Discord stand‑ups (daily) |

---

## **8\. Development Timeline (10 Days)**

| Day | Goal |
| ----- | ----- |
| 1 | Lock palette, set up Git/Trello, scaffold state machine |
| 2 | Implement a stat system & data save/load |
| 3 | Feed & Clean actions are functional |
| 4 | **Sky Flutter** prototype is playable |
| 5 | Hatchling art & basic UI in‑game |
| 6 | Hygiene \+ “Poop” events \+ animation |
| 7 | Juvenile stage & evolution logic |
| 8 | **Community Playtest**: push Web build, collect feedback (Google Form, Discord) |
| 9 | Polish & bug‑fix; integrate critical playtest fixes; wishlist mini‑game if stable |
| 10 | Final build, itch.io page, launch tweet, capture screenshots/GIFs |


---

## **11\. Code Architecture Snapshot**

bash

CopyEdit

`/scenes`

  `Main.tscn         # boot & router`

  `Kaiju.tscn        # pet FSM`

  `UI.tscn           # stat bars, buttons`

  `MiniGame_Sky.tscn # core mini‑game`

  `Shop.tscn         # disabled, future DLC`

`/data`

  `stats.json        # drains & thresholds`

  `items.json        # food defs (price field stub)`

Clean separation showcases future F2P injection without touching core loop.

---

### **Elevator Tagline**

“Care for a cute pixel kaiju, keep it well‑fed and happy, and watch it grow into *Mothlyn* or *Gigazilla*—all crafted in ten jam‑packed days with a laser‑focused scope and professional, future‑ready code.”

## 

## **Code Structure \[ Documentation \]:**

# **Class:   WorldBackground**

### **Inherits:   TextureRect \<   Control \<   CanvasItem \<   Node \<   Object**

Node that holds a \[texture\]: PNG This is the background img used to display the envirorment the v-pet lives in. Currently set to stretch to screen size.

# **Class:   SceneManager**

### **Inherits:   Node \<   Object**

Root node observer. Will handle all scene transitions.

#### **Properties**

1. WorldManagerworld\_manager\[default: \<unknown\>\]

**Property Descriptions**

1. WorldManagerworld\_manager \[default: \<unknown\>\]

	World Observer \- Will receive all children signals. 

# 

# **Class:   PetResource**

### **Inherits:   Resource \<   RefCounted \<   Object**

  There is currently no description for this class.

## Properties

1. Float: happiness \[default: 1.0\]  
2. Float: hunger \[default: 1.0\]  
3. Float: hygiene \[default: 1.0\]  
4. CompressedTexture2D \- sprite

Property Descriptions

##### **● float: happiness \[default: 1.0\]**

##### 

##### Variable holding happiness value,  0 \= empty, 1 \= full.

##### 

##### 

##### **● float: hunger \[default: 1.0\]**

##### 

##### Variable holding hunger value, 0 \= empty, 1 \= full.

##### 

##### 

##### **● float: hygiene \[default: 1.0\]**

##### 

##### Variable holding hygine value, 0 \= empty, 1 \= full.

##### 

##### **● CompressedTexture2Dsprite**

##### 

##### Variable holding sprite

# **Class:   BaseBody**

### **Inherits:   CharacterBody2D \<   PhysicsBody2D \<   CollisionObject2D \<   Node2D \<   CanvasItem \<   Node \<   Object**

 Base body class that all Movable Enteties : Mobs inherit.

## Properties

Int: growth\_speed \[default: 1\]   

PetResource: pet\_resource

## Methods

Void: \_push\_happiness()

Void: update\_globals\_from\_pet(pet: PetResource)

## Property Descriptions

● int: growth\_speed \[default: 1\]

Variable determining the rate in which pet grows.

● PetResourcepet\_resource

Custome resource holding: happiness, hunger, hygiene, sprite

## Method Descriptions

● void \_push\_happiness()

private function that sends happiness to Globals.

● void update\_globals\_from\_pet(pet: PetResource)

Sets up fucntions and variabnles to distribute resource across
