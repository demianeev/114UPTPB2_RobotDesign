# Mathematical Model: Full Documentation

## 📄 Master Document
This directory contains the complete theoretical analysis of the robot in the following PDF file:
* [MATHEMATICAL MODEL OF A 3-DOF CARTESIAN ROBOT.pdf](./MATHEMATICAL%20MODEL%20OF%20A%203-DOF%20CARTESIAN%20ROBOT.pdf)

### PDF Contents
The document covers the following key areas:
1.  **Kinematic Models:** Direct (DKM) and Inverse (IKM) modeling, including Denavit-Hartenberg parameters.
2.  **Jacobian Matrix:** Velocity analysis showing the identity relationship ($J = I_3$) due to the decoupled Cartesian design.
3.  **Dynamic Analysis:** Axis-by-axis decoupled equations of motion ($F = ma + Bv + ...$).
4.  **Actuator Sizing:** Force and torque transmission relations for belt and screw drives.

---

## ⚠️ Implementation Note: Kinematics & Offset
While the PDF presents the fundamental geometric model, the software implementation includes a **Task-Space Shift** to account for the camera offset.

### End-Effector Correction
The standard DH parameters define the robot up to the **wrist** (Link 3). The camera (End-Effector) is mounted with a fixed structural offset ($L_{offset}$).

**Implemented IKM Equation:**
To reach a target coordinate $P_{target}$, the wrist position $q$ is calculated as:

$$
q = P_{target} - L_{offset}
$$

### Jacobian Matrix
As detailed in the document, the Jacobian is the Identity Matrix ($I_3$). This confirms that the joint velocities map one-to-one to the end-effector linear velocities, simplifying the control loop.

$$
\dot{x} = J \dot{q} \quad \Rightarrow \quad \dot{x} = \dot{q}
$$

---

## 🔗 Related Analysis
For a deeper breakdown of the specific calculations derived from this model, please refer to the specific sub-directories:

* **Dynamics & Friction:** See [Dynamic Analysis](../Dynamic%20Analysis)
* **Motor Sizing:** See [Required Force and Torque](../Required%20Force%20and%20Torque)
* **Safety Verification:** See [Safety Factor](../Safety%20Factor)
