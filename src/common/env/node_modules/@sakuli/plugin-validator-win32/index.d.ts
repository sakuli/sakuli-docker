export declare class PluginValidator {
    constructor(name?: string);
    verifyPlugin(plugin: object, userToken: string): boolean;
    verifyEnvironment(environmentToken: string, userToken: string): boolean;
}
