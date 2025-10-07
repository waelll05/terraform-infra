provider "github" {
  token = "" // key for connectivité github
}

resource "github_repository" "terraform-infra-repo" {
  name        = "terraform-infra"
  description = "Infrastructure repository managed by Terraform"
  visibility  = "public"
  has_issues  = true
  has_wiki    = true
}

output "repository_clone_url_ssh" {
  value = github_repository.terraform-infra-repo.ssh_clone_url
}
