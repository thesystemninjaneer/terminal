# terminal

![terminal](img/terminal.png)

Terminal is a RESTful API to collect and discover select data about an organizations distributed system components. Initially, it is a read-only RESTful API to serve as a stub for other applications to test their query and retrieval features.

## Project Components
* [Hugo](https://gohugo.io/): An open source static site generator (SSG) to create custom json output content;
* GitHub: A source code repository service used to track and control this projects content.
* GitHub Pages: A static web content management system (SCM) hosting service used to serve the hugo generated SSG.
* [GitHub Actions](https://github.com/actions/starter-workflows/blob/af51c4b131dbf613bdf369873b9575612522433b/ci/blank.yml): A continuous integration (CI) service hosted by GitHub to automatically build/test/deploy this projects content to GitHub Pages

## How this project was created

### Build Prerequisites
* Fedora 32
```
sudo dnf install hugo
```
### Build Project

Generic commands used to initially test using hugo for an API SSG based on this [tutorial](https://forestry.io/blog/build-a-json-api-with-hugo/) (see learnhugo branch for content).

<details>

```
$ hugo new site terminalGetApi                         #create a new hugo site
$ vim terminalGetApi/config.toml               #set json as the format for hugo to output all rendered content
$ mkdir terminalGetApi/layouts/_default                #
$ vim terminalGetApi/layouts/_default/baseof.json      #starting point for all pages to output a data response
$ vim terminalGetApi/layouts/_default/item.json.json   #template of attributes for a single item
$ vim terminalGetApi/layouts/_default/single.json.json #template to render a response for a single item output using item.json.json template
$ mkdir terminalGetApi/content/FOO/BAR.md              #markup format of attributes for the BAR item of FOO type
$ mkdir terminalGetApi/content/FOO/STUFF.md            #markup format of attributes for the TUFF item of FOO type
$ hugo serve --disableFastRender                       #runs the API as a web service
$ curl http://localhost:1313/index.json                #retrieves json of FOO type of content
$ curl http://localhost:1313/FOO/BAR/index.json        #retrieves json of the single BAR item of type FOO from API
$ vim terminalGetApi/layouts/_default/list.json.json   #template to rendor a response that iterates over all items to output a list of objects as the value of a key called "data"
$ curl http://localhost:1313/FOO/index.json            #retrieves object list of all FOO items as json value for "data" key
$ vim terminalGetApi/static/404.json                   #static error message to use for calls to nonexistent resources
$ mkdir terminalGetApi/content/FOOGROUPS/              #holds content about groups of FOO item types
$ vim terminalGetApi/content/FOOGROUPS/BARGROUP.md     #content for BARGROUP group of FOO type of items
$ vim terminalGetApi/layouts/FOOGROUPS/item.json.json  #define an object to rendor output for a group
$ cp terminalGetApi/layouts/_default/list.json.json layouts/_default/list.json.json.orig
$ vim terminalGetApi/layouts/_default/list.json.json   #update list response template to now include the item type & a tally of an items for the type
$ curl http://localhost:1313/index.json                #returns 2 item types: FOO, FOOGROUP
$ curl http://localhost:1313/FOO/index.json            #returns attributes for 2 FOO items: BAR, STUFF
$ curl http://localhost:1313/FOOGROUPS/index.json      #returns attributes for 1 FOOGROUP item: BARGROUP
$ cp config.toml config.toml.orig
$ vim terminalGetApi/config.toml                       #define new FOOTAXONOMY taxonomy type that relates FOO items to FOOGROUPS & FOOTAXONOMY types and also add it as a new output
$ cp content/FOO/BAR.md content/FOO/BAR.md.orig
$ cp content/FOO/BAR.md content/FOO/STUFF.md.orig
$ vim terminalGetApi/content/FOO/BAR.md                #add new FOOTAXONOMY attribute/key to BAR item and set its value to TAXONOMYA set to BARGROUP
$ vim terminalGetApi/content/FOO/STUFF.md              #add new FOOTAXONOMY attribute/key to STUFF item set to BARGROUP and set its value to TAXONOMYA & TAXONOMYB
$ cp terminalGetApi/layouts/_default/list.json.json terminalGetApi/layouts/_default/list.json.json.orig.second
$ vim terminalGetApi/layouts/_default/list.json.json   #update list template to include new FOOTAXONOMY attribibute when rendoring content pages
$ curl http://localhost:1313/FOOTAXONOMY/TAXONOMYA/index.json   #returns the BAR & STUFF items because they contained both FOOTAXONOMYA & FOOTAXONOMYB keys
$ curl http://localhost:1313/FOOTAXONOMY/TAXONOMYB/index.json   #returns the STUFF item because it contained the FOOTAXONOMYA key
$ vim terminalGetApi/layouts/_default/list.json.json    #update list template response to output if the type is an item or taxonomy
$ curl http://localhost:1313/FOOTAXONOMY/TAXONOMYA/index.json  #returns attributes of TAXONOMYA including the newly added TAXONOMY attribute and value for the TAXONOMYA
$ mkdir terminalGetApi/layouts/FOO
$ cp terminalGetApi/layouts/_default/item.json.json terminalGetApi/layouts/_default/item.json.json.orig
$ mv terminalGetApi/layouts/_default/item.json.json terminalGetApi/layouts/players/   #orig had template in default for simplicity sake but only deals with FOO type so moving to that endpoint folder
$ vim terminalGetApi/layouts/_default/item.json.json   #replace orig with a more generic template
$ curl http://localhost:1313/FOO/BAR/index.json        #returns same BAR details
$ curl http://localhost:1313/FOO/index.json            #returns both BAR & STUFF in new template format
$ curl http://localhost:1313/index.json                #returns FOO type in new template format and FOOGROUP in original template format
$ cp terminalGetApi/config.toml terminalGetApi/config.toml.orig.second
$ vim terminalGetApi/config.toml                       #before it can be deployed in GitHub Pages, update to also include html output format

```

</details>

## Data Schemas

WIP

* [components](schemas/components.yml)
* [apps](schemas/apps.yml)
* [software](schemas/software.yml)

## API Endpoints

* NOTE: The following endpoints are still under construction


| Endpoint            | Resource          |
| -----------------   | -----------------:|
| GET /               | Lists everything  |
| GET /components     | Lists components  |
| GET /components/{:slug} | Data for a single component |
| GET /apps           | Lists applications  |
| GET /apps/{:slug}  | Application data and components |
| GET /software/{:sw} | Lists of components and apps for the specified software |


## Example API Calls

* WIP
```
$ curl http://localhost:1313/components/index.json #returns a list of all components as json objects for the "data" key value
$ curl http://localhost:1313/components/foo/index.json  #returns data for the "foo" component in json format
```
