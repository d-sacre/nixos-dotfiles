{
    packageOverrides = pkgs: {
    blender = pkgs.blender.override {
      blender = blender-hip
    };
  };
}
