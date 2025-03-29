{python3Packages, fetchFromGitHub}:
python3Packages.buildPythonApplication {
  pname = "my_cookies";
  version = "0-unstable-2fdd517";

  src = fetchFromGitHub {
    owner = "kaiwk";
    repo = "my_cookies";
    rev = "2fdd517da0b92792776a34567d2f3cda6f966eac";
    hash = "sha256-gdqG56kpbx5axsHR0nyxjfhpQAdhW9Y6FtWfjxBuVMQ=";
  };

  build-system = [python3Packages.setuptools];
  dependencies = with python3Packages; [
    browser-cookie3
    click
  ];

  meta.mainProgram = "my_cookies";
}
