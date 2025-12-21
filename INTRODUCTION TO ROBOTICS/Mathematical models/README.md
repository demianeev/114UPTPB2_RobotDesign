# Mathematical Models and Analysis

This directory contains the theoretical framework, derivation of equations, and sizing calculations for the 3-DOF Cartesian Robot. The analysis is divided into four main sections, covering kinematics, dynamics, and actuator selection.

## 📂 Directory Contents

### 1. Mathematical Model (Kinematics)

Given the Cartesian nature of the robot, the kinematic description is straightforward. However, to strictly comply with standard kinematic decoupling, we define the control variables in the **wrist frame** and apply a fixed transformation to reach the **end-effector (task space)**.

#### End-Effector Offset Transformation
The DH parameters define the kinematic chain up to the robot's wrist (last prismatic joint). The camera (end-effector) is attached to the wrist with a fixed mechanical offset.

Let the position of the end-effector be $\mathbf{P}_E$ and the position of the wrist be $\mathbf{P}_W$. The relationship is defined by a fixed translation vector $\mathbf{L}_{offset}$:

$$
\mathbf{P}_E = \mathbf{P}_W + \mathbf{L}_{offset}
$$

#### Inverse Kinematic Model (IKM) with Task Space Shift
To reach a desired target coordinate $(x_d, y_d, z_d)$ in the task space, we must first shift the coordinates to the wrist frame. This allows us to correct the IKM without modifying the core DH parameters.

**1. Shift from Task Space to Joint Space:**

$$
\mathbf{P}_W = \mathbf{P}_{target} - \mathbf{L}_{offset}
$$

**2. Solve for Joint Displacements:**
Since the wrist position corresponds directly to the prismatic extensions:

$$
\begin{aligned}
q_1 &= y_d - L_{y,offset} \\
q_2 &= x_d - L_{x,offset} \\
q_3 &= z_d - L_{z,offset}
\end{aligned}
$$

> **Note:** Ideally, for this design, the offsets are purely structural. If the camera is mounted directly below the Z-axis, $L_x$ and $L_y$ may be zero, leaving only a vertical offset $L_z$.

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
