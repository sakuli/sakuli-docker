import {PluginValidator} from "@sakuli/plugin-validator";
import chalk from "chalk";

const LICENSE_KEY = "SAKULI_LICENSE_KEY";
const CONTAINER_IMAGE = "IMG";

const getLicenseToken = () => process.env[LICENSE_KEY];
const getImageName = () => process.env[CONTAINER_IMAGE] || "UNKNOWN_IMAGE";

const getContainerToken = () => "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MTQsImlhdCI6MTU2NjIzMjY4MSwiYXVkIjoidGFjb25zb2wvc2FrdWxpIiwiaXNzIjoic2FrdWxpLmlvIiwic3ViIjoic2FrdWxpX2NvbnRhaW5lciJ9.1UmpXQRfDPmkmsm0U64XJ-is_rz-M9xw34zCY_35pHGi8EN66iMQCRF4OQNw7TzTlD9qf58pkfExprud-ka4RQ";

const validator = new PluginValidator(getImageName());
try {
    validator.verifyEnvironment(getContainerToken(), getLicenseToken() || "");
    process.exit(0);
} catch (e) {
    console.warn(
        chalk`{red Failed to validate container runtime ${getImageName()}. Reason: ${e}}`
    );
    process.exit(-1);
}
