# walteracp.github.io

Personal academic website of Walter Ac-Pangan, agricultural economist.

The whole site is one file, `index.html`, with its styles built in. There is no build step, no Jekyll and no dependencies, so GitHub Pages serves it as is.

```
index.html                  the website
files/photo.jpg             profile photo (square, shown as a circle)
files/CV_WalterAcPangan.pdf CV linked from the menu
files/courses/              course cover images used in the Teaching section
notebooks/                  teaching notebooks linked from the "Notebooks" menu
README.md                   this file
```

## Publish on GitHub Pages

1. Sign in to GitHub as **walteracp** and create a new **public** repository named exactly `walteracp.github.io`. Leave "Add a README" unchecked.
2. Upload the files: on the empty repository page, click **uploading an existing file**, drag in `index.html`, `README.md` and the `files` folder, then click **Commit changes**.
3. Go to **Settings > Pages**. Under "Build and deployment", set **Source** to *Deploy from a branch*, **Branch** to `main` and the folder to `/ (root)`, then save.
4. After a minute or two, the site is live at **https://walteracp.github.io**.

Using git from the command line instead:

```bash
cd walteracp.github.io
git init -b main
git add .
git commit -m "Initial website"
git remote add origin https://github.com/walteracp/walteracp.github.io.git
git push -u origin main
```

## Point walteracpangan.com to GitHub (optional)

Do this only once you are ready to retire the Google Site.

1. In the repository, go to **Settings > Pages > Custom domain**, enter `www.walteracpangan.com` and save. GitHub adds a `CNAME` file to the repository.
2. At your domain registrar, remove the Google Sites DNS records and add:
   - a `CNAME` record for `www` pointing to `walteracp.github.io`
   - four `A` records for the bare domain (`@`) pointing to `185.199.108.153`, `185.199.109.153`, `185.199.110.153` and `185.199.111.153`
3. In Google Sites, unpublish the custom domain or change it to another address.
4. Once DNS has updated (minutes to a few hours), go back to **Settings > Pages** and tick **Enforce HTTPS**.

## Updating the site

- **Text:** edit `index.html` on GitHub (open the file and click the pencil icon), then commit. Each part of the page is marked with a comment such as `<!-- RESEARCH -->`.
- **New paper:** copy an existing `<article class="work">` block and edit it. The grey chips are tags, a `chip lead` is highlighted in blue, and the `<details class="abstract">` block is the abstract that opens on click.
- **CV:** replace `files/CV_WalterAcPangan.pdf` with the new PDF under the same name.
- **Date:** update "Last updated" in the footer.

## Teaching notebooks

The **Notebooks** menu and the R Programming Camp panel link to the pages in `notebooks/`:

- `R_Notes_for_AGECON.html`: R examples, with the runnable script `R_Notes_for_AGECON.R` and the R Markdown source `R_Notes_for_AGECON.Rmd`.
- `Py_Notes_for_AGECON.html`: the Python notes, with `Py_Notes_for_AGECON.ipynb` to download or open in Google Colab.
- `SAS_Notes_for_AGECON.html`: SAS examples, with the runnable script `SAS_Notes_for_AGECON.sas`.
- `Stata_Notes_for_AGECON.html`: Stata examples, with the runnable do-file `Stata_Notes_for_AGECON.do`.

