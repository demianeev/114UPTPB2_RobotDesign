# Mathematical Models and Analysis

This directory contains the theoretical framework, derivation of equations, and sizing calculations for the 3-DOF Cartesian Robot. The analysis is divided into four main sections, covering kinematics, dynamics, and actuator selection.

## 📂 Directory Contents

### 1. Mathematical Model (Kinematics)
Contains the geometric description of the robot's motion.
* **Direct Kinematic Model (DKM):** Maps joint variables ($q_1, q_2, q_3$) to the end-effector position ($x, y, z$).
* **Inverse Kinematic Model (IKM):** Determines required joint displacements for a desired target coordinate.
* **Jacobian Matrix:** Analysis of velocity relationships, which simplifies to an identity matrix $I_3$ due to the decoupled Cartesian design.

### 2. Dynamic Analysis
Describes the forces and torques required to cause motion.
* **Modeling Approach:** A simplified quasi-static model is adopted, neglecting Coriolis and centrifugal terms due to low operating speeds.
* **Decoupled Equations:** The system is analyzed axis-by-axis. The general equation including the optional gravity term ($m_i g$) for the vertical axis is:

$$
m_i \ddot{q} + B_i \dot{q} + F_{ci} \text{sgn}(\dot{q}) + m_i g = F_i
$$

Where $F_i$ represents the actuation force and $F_{ci}$ the Coulomb friction.

### 3. Required Force and Torque
Calculates the minimum mechanical requirements for the actuators, with a specific focus on the Z-axis (vertical lift).
* **Load Analysis:** Calculation of the total moving mass ($m_{total} = m_c + m_m$) and gravitational force ($F_z$).
* **Transmission:** Conversion of linear force to motor torque based on the pulley radius ($r = 8 \text{ mm}$) for the belt drive system:

$$
T = F_z \cdot r
$$

### 4. Safety Factor
Verification of the selected actuators against the calculated requirements.
* **Design Criteria:** Application of a Safety Factor ($SF = 2$) to account for friction variations and manufacturing tolerances.
* **Validation:** Comparison of the design torque ($T_{design}$) against the nominal torque of the NEMA 17 motors ($T_{motor}$) to ensure reliability:

$$
T_{motor} \gg T_{design}
$$
