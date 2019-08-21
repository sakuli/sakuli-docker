const {PluginValidator} = require("./index.js");

describe("PluginValidator", () => {
    it("should also be no-arg constructable", () => {
        // GIVEN

        // WHEN

        // THEN
        expect(() => new PluginValidator()).not.toThrow();
    });

    it.each([
        ["verifyPlugin", "@sakuli/testpackage"],
        ["verifyEnvironment", "consol/sakuli"]
    ])("should provide a %s method", (method, name) => {
        // GIVEN
        const validator = new PluginValidator(name);

        // WHEN

        // THEN
        expect(validator).toHaveProperty(method);
    });
});

describe("PluginValidator-E2E Plugins", () => {
    it.each`
    msg                                     | pluginToken                                                                                                                                                                                                                                                           | userToken                                                                                                                                                                                                                                                                    | expected
    ${"Category matches"}                   | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MSwiaWF0IjoxNTY0NzQ3MjI4LCJhdWQiOiJAc2FrdWxpL3Rlc3RfcGx1Z2luIiwiaXNzIjoic2FrdWxpLmlvIiwic3ViIjoic2FrdWxpX3BsdWdpbiJ9.Nesw1WORjmGQkgMHDR29L7MKlMYKNGdHlbVNL9JZx1ge4wpffDPJt-LwGAxrI8MJDXh_f9dh0Orhj3RCC1vlGw"} | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.CrU7CXpDr62lreHFV7FtkQvXsgQ0vmNS8xYvX5sjcxaOtBIFNaiAg60GKmKP72nMmYnMuzOEIJUW5eSpAbeKYQ"} | ${false}
    ${"Category missmatch"}                 | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MiwiaWF0IjoxNTY0NzQ3NDMyLCJhdWQiOiJAc2FrdWxpL3Rlc3RfcGx1Z2luIiwiaXNzIjoic2FrdWxpLmlvIiwic3ViIjoic2FrdWxpX3BsdWdpbiJ9.QFGsqr4BVer5OQvcMlUNNjMH05nXVTcGYuvivTs10omxsGGqRqWsWGD4heqOYvRsBErc7TUtGGuK-c7VI_8ssQ"} | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.CrU7CXpDr62lreHFV7FtkQvXsgQ0vmNS8xYvX5sjcxaOtBIFNaiAg60GKmKP72nMmYnMuzOEIJUW5eSpAbeKYQ"} | ${true}
    ${"Inclusive category"}                 | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MywiaWF0IjoxNTY0NzQ3NDY3LCJhdWQiOiJAc2FrdWxpL3Rlc3RfcGx1Z2luIiwiaXNzIjoic2FrdWxpLmlvIiwic3ViIjoic2FrdWxpX3BsdWdpbiJ9.Ap-ArpcjfH6DtP-hQC63-WoMdJt9HYd-Xj0DeNRh6Ep-UUGpnFM75jNmkUCfGmDj58VZoGNX_LHSlJXjbVDuMA"} | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.CrU7CXpDr62lreHFV7FtkQvXsgQ0vmNS8xYvX5sjcxaOtBIFNaiAg60GKmKP72nMmYnMuzOEIJUW5eSpAbeKYQ"} | ${false}
    ${"Invalid license token signature"}    | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MywiaWF0IjoxNTY0NzQ3NDY3LCJhdWQiOiJAc2FrdWxpL3Rlc3RfcGx1Z2luIiwiaXNzIjoic2FrdWxpLmlvIiwic3ViIjoic2FrdWxpX3BsdWdpbiJ9.Ap-ArpcjfH6DtP-hQC63-WoMdJt9HYd-Xj0DeNRh6Ep-UUGpnFM75jNmkUCfGmDj58VZoGNX_LHSlJXjbVDuMA"} | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.6GPSsEILBnTFiqNx_zR9D48VNDQySB8v0m3uZoUaB-J2aX-JXVdglaXxZMyaOBDPXDKKP-DjroP-0be-Eyxu3w"} | ${true}
    ${"Invalid plugin token signature"}     | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MywiaWF0IjoxNTY0NzQ3NDY3LCJhdWQiOiJAc2FrdWxpL3Rlc3RfcGx1Z2luIiwiaXNzIjoic2FrdWxpLmlvIiwic3ViIjoic2FrdWxpX3BsdWdpbiJ9.BqHDLrMjqRkYewXEQoZPwpv8CuMFL2YLxB-YrZG-CBrjIUFFMNU7tS_YxRvcaPIQb4FrpZ_Yy8GS-J-sji6b9g"} | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.CrU7CXpDr62lreHFV7FtkQvXsgQ0vmNS8xYvX5sjcxaOtBIFNaiAg60GKmKP72nMmYnMuzOEIJUW5eSpAbeKYQ"} | ${true}
    ${"UserToken empty"}                    | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MywiaWF0IjoxNTY0NzQ3NDY3LCJhdWQiOiJAc2FrdWxpL3Rlc3RfcGx1Z2luIiwiaXNzIjoic2FrdWxpLmlvIiwic3ViIjoic2FrdWxpX3BsdWdpbiJ9.Ap-ArpcjfH6DtP-hQC63-WoMdJt9HYd-Xj0DeNRh6Ep-UUGpnFM75jNmkUCfGmDj58VZoGNX_LHSlJXjbVDuMA"} | ${""}                                                                                                                                                                                                                                                                        | ${true}
    ${"PluginToken empty"}                  | ${""}                                                                                                                                                                                                                                                                 | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.CrU7CXpDr62lreHFV7FtkQvXsgQ0vmNS8xYvX5sjcxaOtBIFNaiAg60GKmKP72nMmYnMuzOEIJUW5eSpAbeKYQ"} | ${true}
  `("$msg throws: $expected", ({msg, pluginToken, userToken, expected}) => {
        // GIVEN
        const validator = new PluginValidator("@sakuli/test_plugin");

        // WHEN

        // THEN
        if (!expected) {
            expect(() =>
                validator.verifyPlugin({pluginToken}, userToken)
            ).not.toThrow();
        } else {
            expect(() =>
                validator.verifyPlugin({pluginToken}, userToken)
            ).toThrow();
        }
    });

    it("should throw on missing package name", () => {
        // GIVEN
        const validator = new PluginValidator();
        const userToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.CrU7CXpDr62lreHFV7FtkQvXsgQ0vmNS8xYvX5sjcxaOtBIFNaiAg60GKmKP72nMmYnMuzOEIJUW5eSpAbeKYQ";
        const pluginToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfcGx1Z2luIiwiYXVkIjoiQHNha3VsaS90ZXN0X3BsdWdpbiIsImNhdGVnb3J5IjoxfQ.RftqaToo4xPb-pmNL52nFqOKynWML3rLyaeAlEKvSVIYv1hmx20TbkXzlntO1jOHvIDhwZLOjNYGI2UNIANl1Q";

        // WHEN

        // THEN
        expect(() =>
            validator.verifyPlugin({pluginToken}, userToken)
        ).toThrowError(
            "Plugin UNKNOWN_PACKAGE provided invalid token: @sakuli/test_plugin"
        );
    });

    it("should only validate plugins with token", () => {
        // GIVEN
        const validator = new PluginValidator();
        const userToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.CrU7CXpDr62lreHFV7FtkQvXsgQ0vmNS8xYvX5sjcxaOtBIFNaiAg60GKmKP72nMmYnMuzOEIJUW5eSpAbeKYQ";

        // WHEN

        // THEN
        expect(() => validator.verifyPlugin({}, userToken)).not.toThrowError();
    });

    it("should throw on missing plugin audience", () => {
        // GIVEN
        const validator = new PluginValidator();
        const userToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.CrU7CXpDr62lreHFV7FtkQvXsgQ0vmNS8xYvX5sjcxaOtBIFNaiAg60GKmKP72nMmYnMuzOEIJUW5eSpAbeKYQ";
        const pluginToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfcGx1Z2luIiwiYXVkIjoiQHNha3VsaS90ZXN0X3BsdWdpbiIsImNhdGVnb3J5Ijo0fQ.xGJTG1IXwKNIV1GaKmer9D8SqMYAsMz72q54zd4LMPJ2nly_NAb_lkCa9Z0bUVDe9YeEXBcROVMcyQPzbHRgMw";

        // WHEN

        // THEN
        expect(() =>
            validator.verifyPlugin({pluginToken}, userToken)
        ).toThrowError(
            "Plugin UNKNOWN_PACKAGE provided invalid token: @sakuli/test_plugin"
        );
    });

    it("should throw on invalid plugin audience", () => {
        // GIVEN
        const packageName = "@sakuli/wrong_package";
        const validator = new PluginValidator(packageName);
        const userToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.CrU7CXpDr62lreHFV7FtkQvXsgQ0vmNS8xYvX5sjcxaOtBIFNaiAg60GKmKP72nMmYnMuzOEIJUW5eSpAbeKYQ";
        const pluginToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfcGx1Z2luIiwiYXVkIjoiQHNha3VsaS90ZXN0X3BsdWdpbiIsImNhdGVnb3J5Ijo0fQ.xGJTG1IXwKNIV1GaKmer9D8SqMYAsMz72q54zd4LMPJ2nly_NAb_lkCa9Z0bUVDe9YeEXBcROVMcyQPzbHRgMw";

        // WHEN

        // THEN
        expect(() =>
            validator.verifyPlugin({pluginToken}, userToken)
        ).toThrowError(
            `Plugin ${packageName} provided invalid token: @sakuli/test_plugin`
        );
    });

    it("should throw on license category missmatch", () => {
        // GIVEN
        const validator = new PluginValidator("@sakuli/test_plugin");
        const userToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.CrU7CXpDr62lreHFV7FtkQvXsgQ0vmNS8xYvX5sjcxaOtBIFNaiAg60GKmKP72nMmYnMuzOEIJUW5eSpAbeKYQ";
        const pluginToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfcGx1Z2luIiwiYXVkIjoiQHNha3VsaS90ZXN0X3BsdWdpbiIsImNhdGVnb3J5Ijo0fQ.xGJTG1IXwKNIV1GaKmer9D8SqMYAsMz72q54zd4LMPJ2nly_NAb_lkCa9Z0bUVDe9YeEXBcROVMcyQPzbHRgMw";

        // WHEN

        // THEN
        expect(() =>
            validator.verifyPlugin({pluginToken}, userToken)
        ).toThrowError(
            "Token missmatch. userToken category 1 does not match pluginToken category 4"
        );
    });

    it("should throw due to invalid license category", () => {
        // GIVEN
        const validator = new PluginValidator("@sakuli/test_plugin");
        const userToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.CrU7CXpDr62lreHFV7FtkQvXsgQ0vmNS8xYvX5sjcxaOtBIFNaiAg60GKmKP72nMmYnMuzOEIJUW5eSpAbeKYQ";
        const pluginToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfcGx1Z2luIiwiYXVkIjoiQHNha3VsaS90ZXN0X3BsdWdpbiIsImNhdGVnb3J5IjoxMDB9.7y7DdYBcH458m6NDDbNRE9BNnIESiUsTvioYA32IL8CrAJOSooOTcLxr8y3BdbgOxxId12BRhVRh52ivPFkQ4A";

        // WHEN

        // THEN
        expect(() =>
            validator.verifyPlugin({pluginToken}, userToken)
        ).toThrowError("Invalid token category: 100");
    });
});

describe("Timestamps Plugins", () => {
    it("should throw due to expired token", () => {
        // GIVEN
        const validator = new PluginValidator("@sakuli/test_plugin");
        const userToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTU2NDA0MDg4NywiYXVkIjoia3VuZGUwODE1In0.n6Q9N1I5wI-nJFiFsnA6q7hS7nwAmx_M5FXzWxlJRbHIfI_6LaMPL_nD_OsPwK9qUQw1uwMwOFpLOn5cbwbBUg";
        const pluginToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfcGx1Z2luIiwiYXVkIjoiQHNha3VsaS90ZXN0X3BsdWdpbiIsImNhdGVnb3J5IjoxMDB9.7y7DdYBcH458m6NDDbNRE9BNnIESiUsTvioYA32IL8CrAJOSooOTcLxr8y3BdbgOxxId12BRhVRh52ivPFkQ4A";

        // WHEN

        // THEN
        expect(() =>
            validator.verifyPlugin({pluginToken}, userToken)
        ).toThrowError("token expired");
    });

    it("should throw due to immature token", () => {
        // GIVEN
        const validator = new PluginValidator("@sakuli/test_plugin");
        const userToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE3MjIwODcyMzMsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.iVBPCFA3yT-BhKzVb469zEMsM170tqC-tE8u-0A25ojZc9dS7RIgACc_XwbQUuLpyEBdoLSqIqOIWJ6Fp_nlaA";
        const pluginToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfcGx1Z2luIiwiYXVkIjoiQHNha3VsaS90ZXN0X3BsdWdpbiIsImNhdGVnb3J5IjoxMDB9.7y7DdYBcH458m6NDDbNRE9BNnIESiUsTvioYA32IL8CrAJOSooOTcLxr8y3BdbgOxxId12BRhVRh52ivPFkQ4A";

        // WHEN

        // THEN
        expect(() =>
            validator.verifyPlugin({pluginToken}, userToken)
        ).toThrowError("immature signature");
    });

    it("should throw due to missing 'exp' timestamp", () => {
        // GIVEN
        const validator = new PluginValidator("@sakuli/test_plugin");
        const userToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImF1ZCI6Imt1bmRlMDgxNSJ9.bHDmBgpQdzxseqNsLGnxh0CEVnXMUjfNH1Evg5_egywxQYF7GWpta_w7_QH1bKVBqRo5O6kCXwOPgImxRS7fNQ";
        const pluginToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfcGx1Z2luIiwiYXVkIjoiQHNha3VsaS90ZXN0X3BsdWdpbiIsImNhdGVnb3J5IjoxMDB9.7y7DdYBcH458m6NDDbNRE9BNnIESiUsTvioYA32IL8CrAJOSooOTcLxr8y3BdbgOxxId12BRhVRh52ivPFkQ4A";

        // WHEN

        // THEN
        expect(() =>
            validator.verifyPlugin({pluginToken}, userToken)
        ).toThrowError("Missing 'exp' timestamp");
    });

    it("should throw due to missing 'nbf' timestamp", () => {
        // GIVEN
        const validator = new PluginValidator("@sakuli/test_plugin");
        const userToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJleHAiOjE3MjIwODcyMzMsImF1ZCI6Imt1bmRlMDgxNSJ9.Ic3N5c30Bd8a8jlQ8j1sSUaTW635ifuHGCVM6OSUQ_1EiG18EG9o-q3Oc9acyDQUyg5nbdtDXVmYFI-Irj-snA";
        const pluginToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfcGx1Z2luIiwiYXVkIjoiQHNha3VsaS90ZXN0X3BsdWdpbiIsImNhdGVnb3J5IjoxMDB9.7y7DdYBcH458m6NDDbNRE9BNnIESiUsTvioYA32IL8CrAJOSooOTcLxr8y3BdbgOxxId12BRhVRh52ivPFkQ4A";

        // WHEN

        // THEN
        expect(() =>
            validator.verifyPlugin({pluginToken}, userToken)
        ).toThrowError("Missing 'nbf' timestamp");
    });
});

describe("PluginValidator-E2E Environment", () => {
    it.each`
    msg                                         | containerToken                                                                                                                                                                                                                                                           | userToken                                                                                                                                                                                                                                                                      | expected
    ${"Category matches"}                       | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MTUsImlhdCI6MTU2NjIwODkzMywiYXVkIjoiY29uc29sL3Nha3VsaSIsImlzcyI6InNha3VsaS5pbyIsInN1YiI6InNha3VsaV9jb250YWluZXIifQ.VLWHQ7R13FMrIEFfmvYgodsaaTxK3ZUN2rVvjRgA6lkKyrQ46ekazWs5POqsQj3ahY47gUgg8jKRqn2ERO0Fgw"} | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.CrU7CXpDr62lreHFV7FtkQvXsgQ0vmNS8xYvX5sjcxaOtBIFNaiAg60GKmKP72nMmYnMuzOEIJUW5eSpAbeKYQ"}      | ${false}
    ${"Category missmatch"}                     | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MTQsImlhdCI6MTU2NjIwODgyMSwiYXVkIjoiY29uc29sL3Nha3VsaSIsImlzcyI6InNha3VsaS5pbyIsInN1YiI6InNha3VsaV9jb250YWluZXIifQ.9vH8eLpus5M7VlWAQpL9tyC6zTUrVMl5Vr5Bbox81Xl-3uolFByTPOdSL0lkpmXPDH9WIdoFGSDMKdwbejrg2w"} | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.CrU7CXpDr62lreHFV7FtkQvXsgQ0vmNS8xYvX5sjcxaOtBIFNaiAg60GKmKP72nMmYnMuzOEIJUW5eSpAbeKYQ"}      | ${true}
    ${"Inclusive category"}                     | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MTUsImlhdCI6MTU2NjIwODkzMywiYXVkIjoiY29uc29sL3Nha3VsaSIsImlzcyI6InNha3VsaS5pbyIsInN1YiI6InNha3VsaV9jb250YWluZXIifQ.VLWHQ7R13FMrIEFfmvYgodsaaTxK3ZUN2rVvjRgA6lkKyrQ46ekazWs5POqsQj3ahY47gUgg8jKRqn2ERO0Fgw"} | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.CrU7CXpDr62lreHFV7FtkQvXsgQ0vmNS8xYvX5sjcxaOtBIFNaiAg60GKmKP72nMmYnMuzOEIJUW5eSpAbeKYQ"}      | ${false}
    ${"Invalid license token signature"}        | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MTUsImlhdCI6MTU2NjIwODkzMywiYXVkIjoiY29uc29sL3Nha3VsaSIsImlzcyI6InNha3VsaS5pbyIsInN1YiI6InNha3VsaV9jb250YWluZXIifQ.VLWHQ7R13FMrIEFfmvYgodsaaTxK3ZUN2rVvjRgA6lkKyrQ46ekazWs5POqsQj3ahY47gUgg8jKRqn2ERO0Fgw"} | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.6GPSsEILBnTFiqNx_zR9D48VNDQySB8v0m3uZoUaB-J2aX-JXVdglaXxZMyaOBDPXDKKP-DjroP-0be-Eyxu3w"} | ${true}
    ${"Invalid container token signature"}      | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MTUsImlhdCI6MTU2NjIwODkzMywiYXVkIjoiY29uc29sL3Nha3VsaSIsImlzcyI6InNha3VsaS5pbyIsInN1YiI6InNha3VsaV9jb250YWluZXIifQ.yd2b0m9FFILf9kh48VS3IFo81fgidLwtJvywvLXTdTj8hvrGv_cvORjmDP79fsApYQcXl_zQYUb-km93D-Zj0Q"} | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.CrU7CXpDr62lreHFV7FtkQvXsgQ0vmNS8xYvX5sjcxaOtBIFNaiAg60GKmKP72nMmYnMuzOEIJUW5eSpAbeKYQ"} | ${true}
    ${"UserToken empty"}                        | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MTQsImlhdCI6MTU2NjIwODgyMSwiYXVkIjoiY29uc29sL3Nha3VsaSIsImlzcyI6InNha3VsaS5pbyIsInN1YiI6InNha3VsaV9jb250YWluZXIifQ.9vH8eLpus5M7VlWAQpL9tyC6zTUrVMl5Vr5Bbox81Xl-3uolFByTPOdSL0lkpmXPDH9WIdoFGSDMKdwbejrg2w"} | ${""}                                                                                                                                                                                                                                                                             | ${true}
    ${"ContainerToken empty"}                   | ${""}                                                                                                                                                                                                                                                                 | ${"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.CrU7CXpDr62lreHFV7FtkQvXsgQ0vmNS8xYvX5sjcxaOtBIFNaiAg60GKmKP72nMmYnMuzOEIJUW5eSpAbeKYQ"}      | ${true}
  `("$msg throws: $expected", ({msg, containerToken, userToken, expected}) => {
        // GIVEN
        const validator = new PluginValidator("consol/sakuli");

        // WHEN

        // THEN
        if (!expected) {
            expect(() =>
                validator.verifyEnvironment(containerToken, userToken)
            ).not.toThrow();
        } else {
            expect(() =>
                validator.verifyEnvironment(containerToken, userToken)
            ).toThrow();
        }
    });

    it("should throw on missing package name", () => {
        // GIVEN
        const validator = new PluginValidator();
        const userToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.CrU7CXpDr62lreHFV7FtkQvXsgQ0vmNS8xYvX5sjcxaOtBIFNaiAg60GKmKP72nMmYnMuzOEIJUW5eSpAbeKYQ";
        const containerToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MTUsImlhdCI6MTU2NjIwODkzMywiYXVkIjoiY29uc29sL3Nha3VsaSIsImlzcyI6InNha3VsaS5pbyIsInN1YiI6InNha3VsaV9jb250YWluZXIifQ.VLWHQ7R13FMrIEFfmvYgodsaaTxK3ZUN2rVvjRgA6lkKyrQ46ekazWs5POqsQj3ahY47gUgg8jKRqn2ERO0Fgw";

        // WHEN

        // THEN
        expect(() =>
            validator.verifyEnvironment(containerToken, userToken)
        ).toThrowError(
            "Container UNKNOWN_ENVIRONMENT provided invalid token: consol/sakuli"
        );
    });

    it("should throw on invalid audience", () => {
        // GIVEN
        const packageName = "consol/sakuli-ubuntu-xfce";
        const validator = new PluginValidator(packageName);
        const userToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.CrU7CXpDr62lreHFV7FtkQvXsgQ0vmNS8xYvX5sjcxaOtBIFNaiAg60GKmKP72nMmYnMuzOEIJUW5eSpAbeKYQ";
        const containerToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MTUsImlhdCI6MTU2NjIwODkzMywiYXVkIjoiY29uc29sL3Nha3VsaSIsImlzcyI6InNha3VsaS5pbyIsInN1YiI6InNha3VsaV9jb250YWluZXIifQ.VLWHQ7R13FMrIEFfmvYgodsaaTxK3ZUN2rVvjRgA6lkKyrQ46ekazWs5POqsQj3ahY47gUgg8jKRqn2ERO0Fgw";

        // WHEN

        // THEN
        expect(() =>
            validator.verifyEnvironment(containerToken, userToken)
        ).toThrowError(
            `Container ${packageName} provided invalid token: consol/sakuli`
        );
    });

    it("should throw on license category missmatch", () => {
        // GIVEN
        const validator = new PluginValidator("consol/sakuli");
        const userToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.CrU7CXpDr62lreHFV7FtkQvXsgQ0vmNS8xYvX5sjcxaOtBIFNaiAg60GKmKP72nMmYnMuzOEIJUW5eSpAbeKYQ";
        const containerToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MTQsImlhdCI6MTU2NjIwODgyMSwiYXVkIjoiY29uc29sL3Nha3VsaSIsImlzcyI6InNha3VsaS5pbyIsInN1YiI6InNha3VsaV9jb250YWluZXIifQ.9vH8eLpus5M7VlWAQpL9tyC6zTUrVMl5Vr5Bbox81Xl-3uolFByTPOdSL0lkpmXPDH9WIdoFGSDMKdwbejrg2w";

        // WHEN

        // THEN
        expect(() =>
            validator.verifyEnvironment(containerToken, userToken)
        ).toThrowError(
            "Token missmatch. userToken category 1 does not match containerToken category 14"
        );
    });

    it("should throw due to invalid license category", () => {
        // GIVEN
        const validator = new PluginValidator("consol/sakuli");
        const userToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.CrU7CXpDr62lreHFV7FtkQvXsgQ0vmNS8xYvX5sjcxaOtBIFNaiAg60GKmKP72nMmYnMuzOEIJUW5eSpAbeKYQ";
        const containerToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MTAwLCJpYXQiOjE1NjYyMDg4MjEsImF1ZCI6ImNvbnNvbC9zYWt1bGkiLCJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfY29udGFpbmVyIn0.C-8mQ8p0ADesJ623EXABUcI5oRS7a_0tISv4bxwjJJkiTiHkV4IDdahOyLSTE8H80TSWf751jf0IxFPI3Pnx8g";

        // WHEN

        // THEN
        expect(() =>
            validator.verifyEnvironment(containerToken, userToken)
        ).toThrowError("Invalid token category: 100");
    });
});

describe("Timestamps Environment", () => {
    it("should throw due to expired token", () => {
        // GIVEN
        const validator = new PluginValidator("consol/sakuli");
        const userToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImV4cCI6MTU2NDA0MDg4NywiYXVkIjoia3VuZGUwODE1In0.n6Q9N1I5wI-nJFiFsnA6q7hS7nwAmx_M5FXzWxlJRbHIfI_6LaMPL_nD_OsPwK9qUQw1uwMwOFpLOn5cbwbBUg";
        const containerToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MTUsImlhdCI6MTU2NjIwODkzMywiYXVkIjoiY29uc29sL3Nha3VsaSIsImlzcyI6InNha3VsaS5pbyIsInN1YiI6InNha3VsaV9jb250YWluZXIifQ.VLWHQ7R13FMrIEFfmvYgodsaaTxK3ZUN2rVvjRgA6lkKyrQ46ekazWs5POqsQj3ahY47gUgg8jKRqn2ERO0Fgw";

        // WHEN

        // THEN
        expect(() =>
            validator.verifyEnvironment(containerToken, userToken)
        ).toThrowError("token expired");
    });

    it("should throw due to immature token", () => {
        // GIVEN
        const validator = new PluginValidator("consol/sakuli");
        const userToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE3MjIwODcyMzMsImV4cCI6MTcyMjA4NzIzMywiYXVkIjoia3VuZGUwODE1In0.iVBPCFA3yT-BhKzVb469zEMsM170tqC-tE8u-0A25ojZc9dS7RIgACc_XwbQUuLpyEBdoLSqIqOIWJ6Fp_nlaA";
        const containerToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MTUsImlhdCI6MTU2NjIwODkzMywiYXVkIjoiY29uc29sL3Nha3VsaSIsImlzcyI6InNha3VsaS5pbyIsInN1YiI6InNha3VsaV9jb250YWluZXIifQ.VLWHQ7R13FMrIEFfmvYgodsaaTxK3ZUN2rVvjRgA6lkKyrQ46ekazWs5POqsQj3ahY47gUgg8jKRqn2ERO0Fgw";

        // WHEN

        // THEN
        expect(() =>
            validator.verifyEnvironment(containerToken, userToken)
        ).toThrowError("immature signature");
    });

    it("should throw due to missing 'exp' timestamp", () => {
        // GIVEN
        const validator = new PluginValidator("consol/sakuli");
        const userToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJuYmYiOjE1NjQwNDA4ODcsImF1ZCI6Imt1bmRlMDgxNSJ9.bHDmBgpQdzxseqNsLGnxh0CEVnXMUjfNH1Evg5_egywxQYF7GWpta_w7_QH1bKVBqRo5O6kCXwOPgImxRS7fNQ";
        const containerToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MTUsImlhdCI6MTU2NjIwODkzMywiYXVkIjoiY29uc29sL3Nha3VsaSIsImlzcyI6InNha3VsaS5pbyIsInN1YiI6InNha3VsaV9jb250YWluZXIifQ.VLWHQ7R13FMrIEFfmvYgodsaaTxK3ZUN2rVvjRgA6lkKyrQ46ekazWs5POqsQj3ahY47gUgg8jKRqn2ERO0Fgw";

        // WHEN

        // THEN
        expect(() =>
            validator.verifyEnvironment(containerToken, userToken)
        ).toThrowError("Missing 'exp' timestamp");
    });

    it("should throw due to missing 'nbf' timestamp", () => {
        // GIVEN
        const validator = new PluginValidator("consol/sakuli");
        const userToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzYWt1bGkuaW8iLCJzdWIiOiJzYWt1bGlfdXNlciIsImNhdGVnb3J5IjoxLCJleHAiOjE3MjIwODcyMzMsImF1ZCI6Imt1bmRlMDgxNSJ9.Ic3N5c30Bd8a8jlQ8j1sSUaTW635ifuHGCVM6OSUQ_1EiG18EG9o-q3Oc9acyDQUyg5nbdtDXVmYFI-Irj-snA";
        const containerToken =
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6MTUsImlhdCI6MTU2NjIwODkzMywiYXVkIjoiY29uc29sL3Nha3VsaSIsImlzcyI6InNha3VsaS5pbyIsInN1YiI6InNha3VsaV9jb250YWluZXIifQ.VLWHQ7R13FMrIEFfmvYgodsaaTxK3ZUN2rVvjRgA6lkKyrQ46ekazWs5POqsQj3ahY47gUgg8jKRqn2ERO0Fgw";

        // WHEN

        // THEN
        expect(() =>
            validator.verifyEnvironment(containerToken, userToken)
        ).toThrowError("Missing 'nbf' timestamp");
    });
});
