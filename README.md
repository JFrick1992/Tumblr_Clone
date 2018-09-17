# Lab 1 - Tumblr Clone

Tumblr Clone is a photo browsing app using the [The Tumblr API](https://www.tumblr.com/docs/en/api/v2#posts).

Time spent: 4 hours spent in total

## User Stories

The following **required** user stories are complete:

- [X] User can scroll through a feed of images returned from the Tumblr API (5pts)

The following **stretch** user stories are implemented:

- [ ] User sees an alert when there's a networking error (+1pt)
- [X] While poster is being fetched, user see's a placeholder image (+1pt)
- [ ] User sees image transition for images coming from network, not when it is loaded from cache (+1pt)
- [ ] Customize the selection effect of the cell (+1pt)

The following **additional** user stories are implemented:

- [ ] List anything else that you can get done to improve the app functionality! (+1-3pts)
-[X] Added pull to refresh

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. In the slides for the program, it sugests gathering all the "posts" from the JSON object and then getting the image link from posts in the cell creation. I could not get the photos to display properly with the way the directions said and changed it to what I believe is a more optimal solution. The soultion is to not have an array of posts, but just go and get the image links and store them in an array of Strings then just looped through all the links in cell creation. 
2. This part expands on part one. That is that in parsing the JSON, access all the main data in the posts and store them in a post object. This will allow with more flexibility in data use because not all the info has to be tied to a single table cell.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

![imgur](https://i.imgur.com/1CQMh6N.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.
One problem was that I tried to do the cell generation (pre grabbing the JSON) off stored knowledge from flix to challenge what I know and missed the line delcaring the ViewController as the data source. This caused some frustration until I realized what was going on. The second would be from part one of the discuss further your piers section which caused annoying formatting problems.

## License

    Copyright [2018] [Jacob Frick]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
