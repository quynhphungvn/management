<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./resource/css/styles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>

<body>
    <main>
        <div id="main-content" class="container-fluid d-flex">
            <div id="mindmap-src" class="col-3">
                <ul class="nav nav-tabs" id="mindmap-tab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#mindmap"
                            type="button" role="tab">Mindmap</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#mindmap-node"
                            type="button" role="tab">Node</button>
                    </li>
                </ul>
                <div class="tab-content" id="mindmap-TabContent">
                    <div class="tab-pane fade show active" id="mindmap" role="tabpanel">
                        <div class="input-group mb-3">
                            <button class="btn btn-outline-secondary" type="button" id="button-addon1">Search</button>
                            <input type="text" class="form-control" placeholder=""
                                aria-label="Example text with button addon" aria-describedby="button-addon1">
                        </div>
                        <div>
                            <div class="list-group">
                                <button type="button" class="list-group-item list-group-item-action active"
                                    aria-current="true">
                                    The current button
                                </button>
                                <button type="button" class="list-group-item list-group-item-action">A second
                                    item</button>
                                <button type="button" class="list-group-item list-group-item-action">A third button
                                    item</button>
                                <button type="button" class="list-group-item list-group-item-action">A fourth button
                                    item</button>
                                <button type="button" class="list-group-item list-group-item-action" disabled>A disabled
                                    button item</button>
                            </div>
                        </div>
                        <div class="input-group input-group-sm mb-3">
                            <span class="input-group-text" id="inputGroup-sizing-sm">Name</span>
                            <input type="text" class="form-control" aria-label="Sizing example input">
                            <button type="button" class="btn btn-primary" onclick="createNewMindMap()">Refresh</button>
                        </div>
                        <div class="mb-3">
                            <label for="exampleFormControlTextarea1" class="form-label">Example textarea</label>
                            <textarea class="form-control" id="mindmap-input" rows="15"></textarea>
                        </div>
                        <div>
                            <button class="btn btn-primary">Clear</button>
                            <button class="btn btn-primary">Save</button>
                            <button class="btn btn-primary">Delete</button>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="mindmap-node" role="tabpanel">
                        <div class="list-group">
                            <button type="button" class="list-group-item list-group-item-action active"
                                aria-current="true">
                                The current button
                            </button>
                            <button type="button" class="list-group-item list-group-item-action">A second item</button>
                            <button type="button" class="list-group-item list-group-item-action">A third button
                                item</button>
                            <button type="button" class="list-group-item list-group-item-action">A fourth button
                                item</button>
                            <button type="button" class="list-group-item list-group-item-action" disabled>A disabled
                                button item</button>
                        </div>
                        <div class="input-group mb-3">
                            <span class="input-group-text">Name</span>
                            <input type="text" class="form-control" placeholder="name">
                        </div>
                        <div class="input-group mb-3">
                            <span class="input-group-text">X1</span>
                            <input id="x1" type="text" class="form-control">
                            <span class="input-group-text">Y1</span>
                            <input id="y1" type="text" class="form-control">
                            <span class="input-group-text">X2</span>
                            <input id="x2" type="text" class="form-control">
                            <span class="input-group-text">Y2</span>
                            <input id="y2" type="text" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="node-note" class="form-label">Note</label>
                            <textarea class="form-control" id="node-note" rows="10"></textarea>
                        </div>
                        <div>
                            <button class="btn btn-primary">Clear</button>
                            <button class="btn btn-primary">Save</button>
                            <button class="btn btn-primary">Delete</button>
                        </div>
                    </div>
                </div>
            </div>
            <div id="mindmap-image" class="col-9 d-flex justify-content-center align-items-center">
                <div>
                    <img id="mindmap-image-el" src="./resource/images/mindmap.png" alt="" onclick="showNodeContent()"
                        ondragstart="getCoordinateStart(event)" ondragend="getCoordinateEnd(event)">
                </div>
            </div>

            <div class="offcanvas offcanvas-end" tabindex="-1" id="myOffcanvas" aria-labelledby="offcanvasRightLabel">
                <div class="offcanvas-header">
                    <h5 id="offcanvasRightLabel">Offcanvas right</h5>
                    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"
                        aria-label="Close"></button>
                </div>
                <div class="offcanvas-body">
                    ...
                </div>
            </div>
        </div>
    </main>
	<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
        integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
        integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
        crossorigin="anonymous"></script>
    <script src="./resource/js/script.js"></script>

</body>

</html>