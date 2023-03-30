// az login
// az account set --subscription 916dfd6d-030c-4bd9-b579-7bb6d1926e97
// az quantum workspace set --resource-group azurequantum --workspace L3-BugBash --location eastus2euap

// az quantum job submit --target-id quantinuum.sim.h1-1e-preview --job-name CheckGHZ --target-capability AdaptiveExecution --shots 50
// az quantum job output -o table --job-id [job-id]

// 10.65 eHQCs with 10 iterations and 50 shots
// Result    Frequency
// --------  -----------  ----------------------
// 0         0.80000000   |████████████████    |
// 1         0.20000000   |████                |

namespace CheckGHZ {

    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    
    @EntryPoint()
    operation CheckGHZ() : Int {
        use q = Qubit[3];
        mutable mismatch = 0;
        for _ in 1..10 {
            H(q[0]);
            CNOT(q[0], q[1]);
            CNOT(q[1], q[2]);

            // Measures and resets the 3 qubits
            let (r0, r1, r2) = (MResetZ(q[0]), MResetZ(q[1]), MResetZ(q[2]));

            // Adjusts classical code based on measurement results
            if not (r0 == r1 and r1 == r2) {
                set mismatch += 1;
            }
        }
        return mismatch;
    }

}
