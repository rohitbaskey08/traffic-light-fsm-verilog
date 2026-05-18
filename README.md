# 🚦 Traffic Signal Controller using Verilog

A **Finite State Machine (FSM)-based Traffic Signal Controller** designed in **Verilog HDL** to manage traffic flow between a **Highway Road** and a **Country Road**. The system dynamically changes traffic signals based on vehicle detection on the country road.

---

# 📌 Project Overview

This project implements a **Traffic Signal Controller** using a **Finite State Machine (FSM)** in Verilog. The controller gives **highest priority to the main highway** since traffic on the highway is continuous. The country road gets access only when vehicles are detected.

The design uses **five states (S0–S4)** to control transitions between **GREEN**, **YELLOW**, and **RED** signals for both roads.

---

# 🚗 Working Principle

The traffic signal for the **main highway gets the highest priority** because vehicles are continuously present on the highway. Therefore, the highway signal remains **GREEN by default**.

Occasionally, vehicles arrive at the **country road**. A **sensor** detects waiting vehicles and sends an input signal **X** to the controller:

* **X = 1** → Cars are present on the country road.
* **X = 0** → No cars are present on the country road.

### Signal Operation

1. **Default Condition**

   * Highway signal remains **GREEN**
   * Country road signal remains **RED**

2. **Car Detected on Country Road (****`X = 1`****)**

   * Highway changes from **GREEN → YELLOW**
   * Then both roads turn **RED**
   * Country road turns **GREEN**

3. **No Cars on Country Road (****`X = 0`****)**

   * Country road changes **GREEN → YELLOW**
   * Then turns **RED**
   * Highway turns **GREEN** again

4. **State Delays**
   Controlled delays are introduced during transitions:

   * **S1 → S2** → Yellow-to-Red delay
   * **S2 → S3** → Red-to-Green delay
   * **S4 → S0** → Yellow-to-Green delay

These delays are configurable using delay parameters in the Verilog code.

---

# ⚙️ FSM State Table

| State  | Highway Signal | Country Signal |
| ------ | -------------- | -------------- |
| **S0** | GREEN          | RED            |
| **S1** | YELLOW         | RED            |
| **S2** | RED            | RED            |
| **S3** | RED            | GREEN          |
| **S4** | RED            | YELLOW         |

---

# 🔄 State Machine Diagram

```md
![State Machine Diagram](/images/dia.png)
```

Example display:

### State Transition Logic

```text
S0 → S1   if X = 1
S0 → S0   if X = 0

S1 → S2   after delay

S2 → S3   after delay

S3 → S3   if X = 1
S3 → S4   if X = 0

S4 → S0   after delay
```

---

# 🧠 State Description

### **S0 – Highway Green**

* Highway = **GREEN**
* Country = **RED**
* Default state
* Waits for car detection signal (`X = 1`)

### **S1 – Highway Yellow**

* Highway = **YELLOW**
* Country = **RED**
* Transition phase before stopping highway traffic

### **S2 – All Red**

* Highway = **RED**
* Country = **RED**
* Safety delay state before country road gets access

### **S3 – Country Green**

* Highway = **RED**
* Country = **GREEN**
* Country road vehicles are allowed to move

### **S4 – Country Yellow**

* Highway = **RED**
* Country = **YELLOW**
* Transition back to highway priority

---


# 🛠️ Technologies Used

* **Verilog HDL**
* **Finite State Machine (FSM)**
* **Vivado / ModelSim**
* **Digital Logic Design**

---


# 👨‍💻 Author

**Rohit Baskey**

If you found this project useful, ⭐ star the repository on GitHub!
