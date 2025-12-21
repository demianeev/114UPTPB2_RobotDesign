# Direct and Inverse Kinematics

## 📄 Documentation
The complete derivation of the Denavit-Hartenberg (DH) parameters and the geometric analysis can be found in the attached document:
* [MATHEMATICAL MODEL OF A 3-DOF CARTESIAN ROBOT.pdf](./MATHEMATICAL%20MODEL%20OF%20A%203-DOF%20CARTESIAN%20ROBOT.pdf)

## ⚠️ Implementation Note: End-Effector Offset
While the PDF document presents the fundamental DH parameters (Table 1), the practical control implementation requires a **Task-Space Shift** to account for the physical distance between the robot's wrist and the camera lens (End-Effector).

### Correction Applied
As per the rigorous kinematic definition, the variables $q_1, q_2, q_3$ drive the **wrist**, not the camera tip. Therefore, the Inverse Kinematic Model (IKM) used in our software includes the following transformation:

**Standard Model (PDF):**
$$q = P_{target}$$

**Corrected Model (Implemented):**
$$q = P_{target} - L_{offset}$$

Where $L_{offset}$ is the fixed vector corresponding to the camera mount length (Link 4 in the DH table).

### Summary of DH Parameters (with Offset)
| Link | $\theta_i$ | $d_i$ | $a_{i-1}$ | $\alpha_{i-1}$ | Note |
| :---: | :---: | :---: | :---: | :---: | :--- |
| **1** | $0$ | $q_1$ | $0$ | $0$ | Vertical Axis |
| **2** | $180^\circ$ | $q_2$ | $0$ | $-90^\circ$ | Horizontal Axis |
| **3** | $-90^\circ$ | $q_3$ | $0$ | $-90^\circ$ | Depth Axis |
| **4** | $0$ | **$L_{offset}$** | $0$ | $0$ | **Fixed Camera Offset** |
