# Git Homework

## Task 1: `git commit -a -m`

### 1. Creating a Git Repository

**Commands Executed:**

```bash
mkdir -p ~/git_homework
cd ~/git_homework
git init
git branch -M main
git status
```

**Output:**

<img width="1026" height="527" alt="image" src="https://github.com/user-attachments/assets/e760cd6d-00af-42f8-b282-46e6e19a839e" />


**Explanation:**

A Git repository was initialized and the default branch was renamed to `main`.

---

### 2. Using `git commit -m`

**Commands Executed:**

```bash
echo "First Git practice" > file1.txt
git status
git add file1.txt
git commit -m "Add first practice file"
git status
git log --oneline -1
```

**Output:**

<img width="1050" height="502" alt="image" src="https://github.com/user-attachments/assets/e50ab483-ec6c-4882-ba6d-e9afc0c1c32f" />



**Explanation:**

`git commit -m` creates a commit using the changes that have already been staged with `git add`. Since `file1.txt` was a new file, it had to be added to the staging area before committing.

---

### 3. Using `git commit -a -m`

The file was modified after it had already been tracked by Git.

**Commands Executed:**

```bash
echo "Second line added" >> file1.txt
git status
git commit -a -m "Update first practice file"
git status
git log --oneline -2
```

**Output:**

<img width="1195" height="446" alt="image" src="https://github.com/user-attachments/assets/0296836f-0c5d-43c9-84a0-03665d751ba4" />



**Explanation:**

`git commit -a -m` automatically stages modifications and deletions of **already tracked files** and commits them. It does not automatically add new untracked files.

The command successfully created:

```text
04c408b Update first practice file
```

---

## Difference Between `git commit -m` and `git commit -a -m`

| Command                            | Description                                                     |
| ---------------------------------- | --------------------------------------------------------------- |
| `git commit -m "message"`          | Commits changes that have already been staged using `git add`.  |
| `git commit -a -m "message"`       | Automatically stages changes to tracked files and commits them. |
| `git commit -a -m` with a new file | Does not include a new untracked file.                          |

---

## Task 2: Git Cherry-Pick

### 1. Creating Commits on Main

Two additional commits were created on the `main` branch.

**Commands Executed:**

```bash
echo "Main branch - commit 3" > main3.txt
git add main3.txt
git commit -m "Add main branch file"

echo "Main branch - commit 4" > main4.txt
git add main4.txt
git commit -m "Add another main file"

git log --oneline --decorate
```

**Output:**

<img width="1258" height="562" alt="image" src="https://github.com/user-attachments/assets/43434b0f-a5e8-4561-855f-6b0f12ab6c55" />



**Explanation:**

Four commits were created on the `main` branch, satisfying the requirement of having 2–4 commits before creating the new branch.

---

### 2. Creating a Feature Branch

**Command Executed:**

```bash
git checkout -b feature
git branch
```

**Output:**

<img width="818" height="175" alt="image" src="https://github.com/user-attachments/assets/af97b607-39f5-48ef-8129-521778063f78" />



**Explanation:**

A new branch named `feature` was created from the `main` branch. The `*` symbol showed that the current branch was `feature`.

---

### 3. Creating Commits on Feature Branch

**Commands Executed:**

```bash
echo "Feature branch - commit 1" > feature1.txt
git add feature1.txt
git commit -m "Add feature one"

echo "Feature branch - commit 2" > feature2.txt
git add feature2.txt
git commit -m "Add feature two"

git log --oneline --decorate
```

**Output:**

<img width="1255" height="495" alt="image" src="https://github.com/user-attachments/assets/8e698373-9495-43fc-a6fa-7e8ac85a9560" />



**Explanation:**

Two commits were created on the `feature` branch:

```text
f733013 Add feature one
3e6ea0c Add feature two
```

The commit `3f0ba1b` was selected for cherry-picking.

---

### 4. Cherry-Picking a Specific Commit

First, the `main` branch was selected:

```bash
git checkout main
```

Then the specific commit was cherry-picked:

```bash
git cherry-pick 3f0ba1b
```

**Output:**

<img width="811" height="213" alt="image" src="https://github.com/user-attachments/assets/d08e5541-e877-4320-b766-9dc7ae1c412b" />



**Explanation:**

`git cherry-pick` applies the changes from a specific commit to the current branch.

The commit `3e6ea0c` from the `feature` branch was selected and successfully applied to `main`.

Git created a new commit:

```text
558db8f Add feature one
```

---

### 5. Verifying the Cherry-Pick

**Commands Executed:**

```bash
git log --oneline --decorate --all
ls -l
```

**Output:**

<img width="1005" height="356" alt="image" src="https://github.com/user-attachments/assets/852596a3-9062-4d5f-8f81-cc314be4b456" />


The resulting log included:

```text
558db8f (HEAD -> main) Add feature two
3e6ea0c (feature) Add feature two
f733013 add feature one
1727746 Ad another main file
6660999 Add main branch file
04c408b Update first practice file
2a9ea5e Add first practice file
```

The `ls -l` output showed:

```text
 feature2.txt
 file1.txt
 main3.txt
 main4.txt
```

`feature1.txt` is available on `main` because its commit was cherry-picked. `feature2.txt` is not present on `main`, showing that only the selected commit was applied.

---
