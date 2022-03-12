{
  description = ''Monitor the state and memory of processes and URL response.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-sermon-v0_2_8.flake = false;
  inputs.src-sermon-v0_2_8.owner = "ThomasTJdev";
  inputs.src-sermon-v0_2_8.ref   = "refs/tags/v0.2.8";
  inputs.src-sermon-v0_2_8.repo  = "nim_sermon";
  inputs.src-sermon-v0_2_8.type  = "github";
  
  inputs."jester".dir   = "nimpkgs/j/jester";
  inputs."jester".owner = "riinr";
  inputs."jester".ref   = "flake-pinning";
  inputs."jester".repo  = "flake-nimble";
  inputs."jester".type  = "github";
  inputs."jester".inputs.nixpkgs.follows = "nixpkgs";
  inputs."jester".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-sermon-v0_2_8"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-sermon-v0_2_8";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}