# intro-git

## Introduction to Git and GitHub

Git is a version control system that tracks changes in your code, allowing multiple people to work on a project simultaneously. GitHub is a web-based platform that utilizes Git for collaborative software development.

### Key Concepts

- **Repository (Repo):** A repository is like a project folder that contains all the files, revision history, and configuration files. It can be local (on your machine) or remote (on GitHub).

- **Forking:** Forking a repository on GitHub creates a copy of the original repository in your GitHub account. It allows you to make changes without affecting the original project.

- **Cloning:** Cloning a repository means creating a local copy on your machine. This is what you'll work on and where you'll make changes before pushing them back to the remote repository.

- **Branch:** A branch is a parallel version of the code. It allows you to work on new features or bug fixes without affecting the main codebase.

- **Pull Request (PR):** A pull request is a proposal to merge changes from one branch into another. It facilitates collaboration and code review.

- **Commit:** A commit is a snapshot of your project at a specific point in time. It includes changes to files that you've made and serves as a record in the version history. Commits help you track the development progress and easily revert to a specific state if needed.

- **Staging Area:** Before committing changes, you need to stage them. The staging area is a step between modifying your files and committing those changes. It allows you to selectively choose which changes to include in the next commit. `git add` is used to stage changes.

- **Remote:** In Git, a remote is a version of your repository hosted on another server. It could be a repository on GitHub or another Git hosting service. Remotes allow you to collaborate with others by fetching and pushing changes between your local repository and the remote repository. Common remote names are "origin" (your fork on GitHub) and "upstream" (the original repository).

## Getting Started

1. **Create a GitHub Account:**
   - Go to [Creating an account on GitHub](https://docs.github.com/en/get-started/quickstart/creating-an-account-on-github) and sign up for an account.

2. **Fork this Repository:**
   - Click the "Fork" button at the top-right of [this repository](https://github.com/thecocolab/crash-course.git) to create your copy.

3. **Clone your Fork:**
   - Clone your fork to your local machine using the command:
     ```
     $ git clone https://github.com/your-username/crash-course.git
     ```

4. **Configure Git:**
   - Set up your Git configuration with your name and email:
     ```
     $ git config --global user.name "Your Name"
     $ git config --global user.email youremail@example.com
     $ git config --global color.ui auto
     ```

## Working with Git

### Branching

- **Check Current Branch:**
  ```
  $ git branch -v
  ```

- **Create a New Branch:**
  ```
  $ git branch cool-feature
  ```

- **Switch to a Branch:**
  ```
  $ git checkout cool-feature
  ```

- **Delete a Branch:**
  ```
  $ git checkout main
  $ git branch -D cool-feature
  ```

### Making a Commit

- **Check Changes:**
  ```
  $ git diff
  ```

- **Add to Staging Area:**
  ```
  $ git add <filename>
  ```

- **Commit Changes:**
  ```
  $ git commit -m "My new feature"
  ```

- **Check Commit History:**
  ```
  $ git log
  ```

### Additional: Working Collaboratively

- **List Remotes:**
  ```
  $ git remote -v
  ```

- **Set Up "upstream" Remote:**
  ```
  $ git remote add upstream https://github.com/thecocolab/crash-course.git
  ```

- **Push a Branch to Your Fork:**
  ```
  $ git push origin cool-feature
  ```

- **Fetch Updates from "upstream":**
  ```
  $ git fetch upstream main:main
  ```

## Git and GitHub Tutorial

- For a full tutorial on using git and github check this [Video](https://youtu.be/fBgxmpk9C4I?si=nDAjC5j9F1WQVWht)

## Additional Resources

- [Hello World GitHub Guide](https://docs.github.com/en/get-started/quickstart/hello-world)
- [Set Up Git - GitHub Docs](https://docs.github.com/en/get-started/getting-started-with-git/set-up-git)
- [GitHub Glossary](https://docs.github.com/en/get-started/quickstart/github-glossary)

## GitHub Pro and Copilot:

Requirements: a valid student card.
 - First you have to sign in for Student developer pack by Github: You can find steps through this [link](https://docs.github.com/en/education/explore-the-benefits-of-teaching-and-learning-with-github-education/github-global-campus-for-students/apply-to-github-global-campus-as-a-student#applying-to-github-global-campus). This will take 5 minutes to finish and they accepted my application in 3 days.
- Install Visual Studio code (Will be done at module 2.2).
- Install Github Capilot extension.  Steps. The main task of GitHub Copilot is completing code.

If you want to have a chatgpt like feature you need to install GitHub Copilot Chat:
Requirements: Last version of visual studio July 2023 (version 1.81). For Linux/windows: In help menu select check updates. For mac  In Code menu select check updates.

- First you have to go to Extensions: marketplace
- Then look for github copilot chat, install the extension.
- Join the waitlist for this feature. When you are Accepted to GitHub Copilot chat beta. A new chat icon below extensions on the left side will appear.


