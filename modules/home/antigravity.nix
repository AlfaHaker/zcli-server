{...}: {
  programs = {
    antigravity.enable = true;
    antigravity-cli = {
      enable = true;
      settings = {
        altScreenMode = "always";
        #artifactReviewPolicy = "agent-decides";
        colorScheme = "tokyo night";
        #toolPermission = "proceed-in-sandbox";
      };
    };
  };
}
